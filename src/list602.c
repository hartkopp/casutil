/*
 *  list602.c - List Casio FX-601P/FX-602P tape files
 *
 *  This program displays the contents of a tape image saved by the
 *  FX-601P or FX-602P calculator through the FA-1 or FA-2 cassette
 *  interface. Program, data and "all" files are supported. Files can
 *  have a file number instead of a file name, as saved by the FX-502P.
 *  Program and data files of the FX-501P/FX-502P are supported as well.
 *
 *  Options:
 *    -b<skip> read BIN file (Default); skip <skip> garbage bytes
 *    -w       read WAV file
 *    -i       ignore bytes with parity or framing errors
 *    -u       use UTF-8 characters instead of ASCII
 *    -s       show the step numbers
 *    -x       show the hex codes of all steps and the step numbers
 *
 *  Each file starts with comment lines describing the file for prg602:
 *    # @calculator 602, 601, 502 or 501
 *    # @file program, data, all or display
 *    # @name "name" or # @number n, missing if the file has no name
 *    # @mode .nn, the memory partition of the FX-602P
 *
 *  File format:
 *    8 header bytes: 2 type bytes, file name or number (see getName())
 *    program steps and/or data registers (8 bytes each)
 *    8 bytes 0xFF terminate the program and the data part
 *
 *  File format of the FX-501P/FX-502P (see listFile502()):
 *    2 header bytes: type and file number
 *    the whole program area or 22 data registers
 *    8 bytes 0xFF
 *
 *  Sources:
 *    Character and keyword codes by Mahmoud Yassine on the pages of
 *    Piotr Piatek, https://www.pisi.com.pl/piotr433/fx602foe.htm
 *    File format by Martin Krischik, https://fx-602p.krischik.com
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include "wave.h"
#include "fx602.h"

#define MAX_BYTES  0x10000    /* more than any tape file */
#define LEAD_IN    -1         /* lead-in marker in the input buffer */
#define DISPLAY_LEN   16      /* bytes of alpha display data */
#define DISPLAY_CHARS 11      /* characters shown in the display */
#define PARTITION601  0x10    /* FX-601P: 128 steps */
#define REGISTERS601  16      /* FX-601P: M00..M09, MF and 5 L registers */

/*
 *  Options
 */
bool Utf8 = false;
bool ShowHex = false;
bool ShowSteps = false;
bool File502 = false;         /* file of the FX-501P/FX-502P */

/*
 *  Input buffer, filled by the reading routines
 */
int Data[ MAX_BYTES ];
int Count = 0;

/*
 *  Name in ASCII or UTF-8 (option -u)
 */
#define NAME_OF( n ) ( Utf8 && ( n ).utf8 != NULL ? ( n ).utf8 : ( n ).ascii )


/*
 *  Name of a memory operation including the prefix offset
 *  Returns false if the token isn't a memory operation
 */
bool memoryName( char *buffer, int token, int offset )
{
    int row = token >> 4;
    int col = token & 0x0F;
    int op, group, index;
    char reg[ 16 ];

    if ( row >= 0x5 && row <= 0xE && col <= 9 ) {
        op = ( row - 5 ) % 5;
        group = offset / 10 + ( row >= 0xA ? 1 : 0 );
        index = col;
    }
    else if ( row == 0xF && col <= 9 ) {
        op = col % 5;
        group = offset / 10 + ( col >= 5 ? 1 : 0 );
        index = 10;
    }
    else {
        return false;
    }
    if ( File502 && group <= 1 ) {
        /*
         *  M0..M9, MF, M.0..M.9, M.F
         */
        sprintf( reg, "%s%c", group ? "." : "", index < 10 ? '0' + index : 'F' );
    }
    else {
        registerName( reg, group, index );
    }
    sprintf( buffer, "%s%s", NAME_OF( MemoryOps[ op ] ), reg );
    return true;
}


/*
 *  Check for the display of a memory register in alpha text, which may
 *  follow a prefix for the registers M20..M99
 */
bool isMemoryDisplay( int code )
{
    return ( code >= 0x60 && code <= 0x69 ) || ( code >= 0xB0 && code <= 0xB9 )
        || code == 0xF1 || code == 0xF6;
}


/*
 *  Name of an alpha register display (\ARXX, INV AR on the keyboard)
 *  including the prefix offset
 *  Returns false if the code isn't an alpha register display
 */
bool alphaRegister( char *buffer, int code, int offset )
{
    char reg[ 16 ];

    if ( code >= 0x60 && code <= 0x69 ) {
        registerName( reg, offset / 10, code - 0x60 );
    }
    else if ( code >= 0xB0 && code <= 0xB9 ) {
        registerName( reg, offset / 10 + 1, code - 0xB0 );
    }
    else if ( code == 0xF1 || code == 0xF6 ) {
        registerName( reg, offset / 10 + ( code == 0xF6 ? 1 : 0 ), 10 );
    }
    else if ( offset == 0 && ( ( code >= 0x6B && code <= 0x6F )
                               || ( code >= 0xBB && code <= 0xBF ) ) )
    {
        /*
         *  Registers for parentheses L2..L11 (synthetic), L0 is x and L1 is y
         */
        sprintf( reg, "L%d", ( code & 0x0F ) - 0x0B + ( code >= 0xB0 ? 7 : 2 ) );
    }
    else {
        return false;
    }
    sprintf( buffer, "\\AR%s", reg );
    return true;
}


/*
 *  Print a single alpha character
 */
void printAlpha( int code, int offset )
{
    char buffer[ 16 ];

    if ( alphaRegister( buffer, code, offset ) ) {
        fputs( buffer, stdout );
    }
    else if ( Alpha[ code ].ascii != NULL ) {
        fputs( NAME_OF( Alpha[ code ] ), stdout );
    }
    else {
        printf( "\\%02X", code );
    }
}


/*
 *  Check the sign digit in byte 1 of a data register:
 *  hundreds digit of the biased exponent (0 or 1), plus 5 if negative,
 *  the FX-502P adds 8 instead of 5
 */
bool isSignDigit( int digit )
{
    return digit == 0 || digit == 1 || digit == 5 || digit == 6
        || digit == 8 || digit == 9;
}


/*
 *  Check for a valid BCD coded data register
 */
bool isRegister( const int *p )
{
    int i;

    for ( i = 0; i < REG_LEN; ++i ) {
        if ( p[ i ] < 0 || ( p[ i ] & 0x0F ) > 9 || ( p[ i ] >> 4 ) > 9 ) {
            return false;
        }
    }
    /*
     *  Unused nibbles and sign
     */
    return ( p[ 1 ] >> 4 ) == 0 && isSignDigit( p[ 1 ] )
        && ( p[ 2 ] & 0x0F ) == 0 && ( p[ 7 ] >> 4 ) == 0;
}


/*
 *  Check for a data register with a valid exponent but non decimal
 *  digits in the mantissa, e.g. created by synthetic programming
 */
bool isSyntheticRegister( const int *p )
{
    int i;

    for ( i = 0; i < REG_LEN; ++i ) {
        if ( p[ i ] < 0 ) {
            return false;
        }
    }
    return ( p[ 0 ] & 0x0F ) <= 9 && ( p[ 0 ] >> 4 ) <= 9
        && ( p[ 1 ] >> 4 ) == 0 && isSignDigit( p[ 1 ] )
        && ( p[ 2 ] & 0x0F ) == 0 && ( p[ 7 ] >> 4 ) == 0;
}


/*
 *  Find the end of the valid data registers starting at Data[ start ]
 *  Returns start if there is no valid register
 */
int registerEnd( int start, int end )
{
    int i;

    for ( i = start; i + REG_LEN <= end && isRegister( Data + i ); i += REG_LEN )
        ;
    return i;
}


/*
 *  Check if Data[ start ] .. Data[ end - 1 ] are alpha characters,
 *  including the prefixes for the register display
 */
bool isAlphaText( int start, int end )
{
    char buffer[ 16 ];
    int i;

    for ( i = start; i < end; ++i ) {
        if ( Alpha[ Data[ i ] ].ascii == NULL
             && !alphaRegister( buffer, Data[ i ], 0 )
             && !( Data[ i ] >= TOKEN_F1 && Data[ i ] <= TOKEN_F4 ) )
        {
            return false;
        }
    }
    return end > start;
}


/*
 *  Check if Data[ start ] .. Data[ end - 1 ] contains program markers
 *  (0x00..0x09), labels (0x20..0x29) or HLT (0x2A)
 */
bool containsLabels( int start, int end )
{
    int i;

    for ( i = start; i < end; ++i ) {
        if ( Data[ i ] <= 0x09 || ( Data[ i ] >= 0x20 && Data[ i ] <= 0x2A ) ) {
            return true;
        }
    }
    return false;
}


const char HexDigits[] = "0123456789ABCDEF";

/*
 *  Print a BCD coded number
 *  Non decimal digits of synthetic numbers are shown as hex digits.
 *
 *  Byte 0: exponent digits 2 and 3
 *  Byte 1: exponent digit 1, plus 5 (FX-502P: 8) if the number is negative
 *  Byte 2: mantissa digit 10 (high nibble)
 *  Byte 3..6: mantissa digits 9..2
 *  Byte 7: mantissa digit 1 (low nibble)
 *  The exponent is biased by 100, e.g. -2.5 is 00 06 00 00 00 00 50 02
 *  and 1.23456789E-45 is 55 00 00 89 67 45 23 01.
 */
void printNumber( const int *p )
{
    char digits[ 11 ];
    bool negative = p[ 1 ] >= 5;
    int exponent, i, n;

    exponent = ( p[ 1 ] >= 8 ? p[ 1 ] - 8 : p[ 1 ] % 5 ) * 100
             + ( p[ 0 ] >> 4 ) * 10
             + ( p[ 0 ] & 0x0F ) - 100;
    digits[ 0 ] = HexDigits[ p[ 7 ] & 0x0F ];
    for ( i = 1; i < 9; ++i ) {
        int b = p[ 6 - ( i - 1 ) / 2 ];
        digits[ i ] = HexDigits[ i % 2 ? b >> 4 : b & 0x0F ];
    }
    digits[ 9 ] = HexDigits[ p[ 2 ] >> 4 ];
    digits[ 10 ] = '\0';

    /*
     *  Number of significant digits
     */
    for ( n = 10; n > 1 && digits[ n - 1 ] == '0'; --n )
        ;
    if ( n == 1 && digits[ 0 ] == '0' ) {
        printf( "0" );
        return;
    }
    if ( negative ) {
        printf( "-" );
    }
    if ( exponent >= 0 && exponent < 10 ) {
        /*
         *  Fixed point, integer part
         */
        for ( i = 0; i <= exponent; ++i ) {
            putchar( i < n ? digits[ i ] : '0' );
        }
        if ( n > exponent + 1 ) {
            printf( ".%.*s", n - exponent - 1, digits + exponent + 1 );
        }
    }
    else if ( exponent < 0 && exponent > -10 ) {
        /*
         *  Fixed point, small number
         */
        printf( "0.%.*s%.*s", -exponent - 1, "000000000", n, digits );
    }
    else {
        /*
         *  Scientific notation
         */
        printf( "%c", digits[ 0 ] );
        if ( n > 1 ) {
            printf( ".%.*s", n - 1, digits + 1 );
        }
        printf( "E%+03d", exponent );
    }
}


/*
 *  Check if prg602 creates the same bytes from the number printed by
 *  printNumber(): the mantissa is normalized, a zero has no exponent and
 *  sign, the exponent is not -100 and the sign digit is the one of the
 *  calculator (5 or 8 added if negative)
 */
bool isLossless( const int *p )
{
    int sign = p[ 1 ];
    bool zero = ( p[ 2 ] >> 4 ) == 0 && p[ 3 ] == 0 && p[ 4 ] == 0
                && p[ 5 ] == 0 && p[ 6 ] == 0 && ( p[ 7 ] & 0x0F ) == 0;

    if ( zero ) {
        return p[ 0 ] == 0 && p[ 1 ] == 0;
    }
    if ( ( p[ 7 ] & 0x0F ) == 0 || ( sign == 0 && p[ 0 ] == 0 ) ) {
        return false;
    }
    return sign <= 1 || sign == ( File502 ? 8 : 5 ) || sign == ( File502 ? 9 : 6 );
}


/*
 *  Print the data register at Data[ i ]
 */
void printRegister( int i )
{
    if ( isRegister( Data + i ) ) {
        printNumber( Data + i );
    }
    else if ( isSyntheticRegister( Data + i ) ) {
        printNumber( Data + i );
        printf( "  (synthetic)" );
    }
    else {
        /*
         *  Not a number, e.g. a register that was assigned with
         *  MODE . but never cleared
         */
        int j;
        printf( "[" );
        for ( j = 0; j < REG_LEN; ++j ) {
            printf( j ? " %02X" : "%02X", Data[ i + j ] );
        }
        printf( "]" );
    }
    if ( ( ShowHex || !isLossless( Data + i ) )
         && ( isRegister( Data + i ) || isSyntheticRegister( Data + i ) ) )
    {
        int j;
        printf( "  [" );
        for ( j = 0; j < REG_LEN; ++j ) {
            printf( j ? " %02X" : "%02X", Data[ i + j ] );
        }
        printf( "]" );
    }
    printf( "\n" );
}


/*
 *  Print the L registers for parentheses of the FX-501P and FX-601P,
 *  the registers first .. count - 1 at Data[ start ], with their position
 */
void listParentheses( int start, int first, int count )
{
    int n;

    printf( "\nL registers (parentheses)\n\n" );
    for ( n = first; n < count; ++n ) {
        printf( "[%02d] = ", n );
        printRegister( start + n * REG_LEN );
    }
}


/*
 *  Print the data registers in Data[ start ] .. Data[ end - 1 ]
 *  Order: M00..M09, MF, M10..M19, M1F, ...
 */
void listRegisters( int start, int end )
{
    char reg[ 16 ];
    int i, n;

    for ( i = start, n = 0; i + REG_LEN <= end; i += REG_LEN, ++n ) {
        registerName( reg, n / 11, n % 11 );
        printf( "M%-3s = ", reg );
        printRegister( i );
    }
}


/*
 *  Print the step number and the hex codes of a step, if selected
 */
void stepStart( int step, int start, int length )
{
    int i;

    printf( ShowSteps ? "  %03d  " : "  ", step );
    if ( ShowHex ) {
        for ( i = 0; i < 3; ++i ) {
            if ( i < length && i < 2 ) {
                printf( "%02X ", Data[ start + i ] );
            }
            else if ( i == 2 && length > 2 ) {
                printf( ".. " );
            }
            else {
                printf( "   " );
            }
        }
        printf( " " );
    }
}


/*
 *  List the program steps in Data[ start ] .. Data[ end - 1 ]
 */
void listProgram( int start, int end )
{
    char buffer[ 32 ];
    int i = start;
    int step = 0;
    bool first = true;

    if ( start < end && Data[ start ] > 0x09 ) {
        /*
         *  Steps outside of any program, e.g. in front of P0 in the
         *  program area of an "all" file
         */
        printf( "No program\n" );
        first = false;
    }

    while ( i < end ) {
        int c = Data[ i ];

        if ( c <= 0x09 ) {
            int j;

            /*
             *  Start of a program, step numbers restart
             */
            printf( "%sP%d\n", first ? "" : "\n", c );
            step = 0;
            ++i;

            /*
             *  A password may follow the program marker: 4 alpha
             *  characters in reverse order, terminated by 0xEC.
             *  Each program has its own password.
             */
            for ( j = i; j < end && j < i + PASSWORD_LEN; ++j ) {
                if ( Alpha[ Data[ j ] ].ascii == NULL ) {
                    break;
                }
            }
            if ( j == i + PASSWORD_LEN && j < end && Data[ j ] == TOKEN_PASSWORD ) {
                printf( "  Password \"" );
                while ( --j >= i ) {
                    printAlpha( Data[ j ], 0 );
                }
                printf( "\"\n" );
                while ( Data[ i ] != TOKEN_PASSWORD ) {
                    ++i;
                }
                ++i;
            }
            first = false;
            continue;
        }
        first = false;

        if ( c == TOKEN_ALPHA ) {
            /*
             *  Alpha text up to the closing 0x2B, prefixes select
             *  the register groups of \ARXX.
             *  Some programs contain a single 0x2B followed by normal
             *  program steps. It is listed as code [2B] if the text up to
             *  the next 0x2B contains program markers, labels or HLT,
             *  which have no meaning in alpha mode.
             */
            int j = i + 1;
            int offset = 0;

            while ( j < end && Data[ j ] != TOKEN_ALPHA ) {
                ++j;
            }
            if ( j < end && containsLabels( i + 1, j ) ) {
                stepStart( ++step, i, 1 );
                printf( "[%02X]\n", c );
                ++i;
                continue;
            }
            stepStart( ++step, i, j < end ? j - i + 1 : j - i );
            printf( "\"" );
            for ( ++i; i < j; ++i ) {
                /*
                 *  A prefix without a register display is shown as \XX
                 */
                if ( Data[ i ] >= TOKEN_F1 && Data[ i ] <= TOKEN_F4
                     && i + 1 < j && isMemoryDisplay( Data[ i + 1 ] ) )
                {
                    offset = ( Data[ i ] - TOKEN_F1 + 1 ) * 20;
                    ++step;
                    continue;
                }
                printAlpha( Data[ i ], offset );
                offset = 0;
                ++step;
            }

            /*
             *  \FF instead of the closing quote, if the program ends
             *  without the closing 0x2B
             */
            printf( i < end ? "\"\n" : "\\FF\n" );
            if ( i < end ) {
                /*
                 *  Closing 0x2B
                 */
                ++step;
                ++i;
            }
            continue;
        }

        if ( c >= TOKEN_F1 && c <= TOKEN_F4 && i + 1 < end ) {
            /*
             *  Prefix for the registers M20..M99 or FIX
             */
            int offset = ( c - TOKEN_F1 + 1 ) * 20;
            int t = Data[ i + 1 ];

            if ( memoryName( buffer, t, offset ) ) {
                stepStart( ++step, i, 2 );
                printf( "%s\n", buffer );
                ++step;
                i += 2;
                continue;
            }
            if ( c == TOKEN_F1 && t >= 0x10 && t <= 0x19 ) {
                stepStart( ++step, i, 2 );
                printf( "FIX%d\n", t - 0x10 );
                ++step;
                i += 2;
                continue;
            }
        }

        stepStart( ++step, i, 1 );
        if ( memoryName( buffer, c, 0 ) ) {
            printf( "%s\n", buffer );
        }
        else if ( Tokens[ c ].ascii != NULL ) {
            printf( "%s\n", NAME_OF( Tokens[ c ] ) );
        }
        else {
            printf( "[%02X]\n", c );
        }
        ++i;
    }
}


/*
 *  Restore bit 7 of an alpha character: it is not stored in file names,
 *  lower case letters and the codes 0xAA..0xAF appear as 0x10..0x2F
 */
int alphaBit7( int c )
{
    return c >= 0x10 && c <= 0x2F ? c | 0x80 : c;
}


/*
 *  Decode the alpha display data of the calculator into c[ 16 ]:
 *  byte k holds the high nibbles and byte k + 8 the low nibbles of
 *  two characters, stored from the end. The text is right aligned and
 *  padded with 0x0F, followed by 5 codes of unknown meaning, usually
 *  CC 44 E0 00 FF. Bit 7 of the characters is not stored as in file
 *  names, but it is always set for the sixth character.
 */
void decodeDisplay( int *c, const int *p )
{
    int k;

    for ( k = 0; k < 8; ++k ) {
        c[ 14 - 2 * k ] = ( p[ k ] & 0xF0 ) | ( p[ k + 8 ] >> 4 );
        c[ 15 - 2 * k ] = ( p[ k ] << 4 & 0xF0 ) | ( p[ k + 8 ] & 0x0F );
    }
}


/*
 *  Character n of the decoded alpha display data
 */
int displayChar( const int *c, int n )
{
    return alphaBit7( c[ n ] & 0x7F );
}


/*
 *  Index of the first character of the alpha display data,
 *  after the padding
 */
int displayStart( const int *c )
{
    int i;

    for ( i = 0; i < DISPLAY_CHARS && displayChar( c, i ) == 0x0F; ++i )
        ;
    return i;
}


/*
 *  Check if prg602 creates the same codes from the text of the alpha
 *  display data: padding 0x0F, no bit 7 but for the sixth character and
 *  the codes CC 44 E0 00 FF behind the text
 */
bool isDisplayDescribed( const int *c )
{
    static const int behind[] = { 0xCC, 0x44, 0xE0, 0x00, 0xFF };
    int start = displayStart( c );
    int i;

    for ( i = 0; i < DISPLAY_LEN; ++i ) {
        int e = i >= DISPLAY_CHARS ? behind[ i - DISPLAY_CHARS ]
              : ( i < start ? 0x0F : c[ i ] & 0x7F ) | ( i == 5 ? 0x80 : 0 );

        if ( c[ i ] != e ) {
            return false;
        }
    }
    return true;
}


/*
 *  Check for alpha display data of the calculator
 */
bool isDisplayText( const int *p )
{
    int c[ DISPLAY_LEN ];
    int i;

    decodeDisplay( c, p );
    for ( i = displayStart( c ); i < DISPLAY_CHARS; ++i ) {
        if ( Alpha[ displayChar( c, i ) ].ascii == NULL ) {
            return false;
        }
    }
    return true;
}


/*
 *  Print the line "# @number" for prg602 from the digit bytes d12 (first
 *  and second digit) and d3 (third digit in the high nibble), nothing for
 *  the number 000, which means no name
 */
void printNumber502( int d12, int d3 )
{
    int d1 = d12 >> 4, d2 = d12 & 0x0F;

    d3 >>= 4;
    if ( ( d1 != 0 || d2 != 0 || d3 != 0 ) && d1 <= 9 && d2 <= 9 && d3 <= 9 ) {
        printf( "# @number %d\n", d1 * 100 + d2 * 10 + d3 );
    }
    else if ( d1 > 9 || d2 > 9 || d3 > 9 ) {
        printf( "# Invalid file number %X%X%X\n", d1, d2, d3 );
    }
}


/*
 *  Decode the file name or number from the header
 *
 *  File number (FX-502P, FX-602P): header[ 2 ] = last digit and 0xA,
 *                                  header[ 3 ] = first and second digit,
 *                                  header[ 4..7 ] = 0xFF
 *  The file number 000 is used if no name or number is entered.
 *  FX-602P file name: 6 alpha characters without bit 7, nibbles spread
 *                     over the bytes 2..7
 *  Returns the file number, 0 if there is no name, -1 for a name stored
 *  in codes[] with the length *len, -2 for an invalid number
 */
int decodeName( const int *h, int *codes, int *len )
{
    int c[ NAME_LEN ];
    int i, n;

    if ( h[ 2 ] == 0xFF && h[ 3 ] == 0xFF && h[ 4 ] == 0xFF
         && h[ 5 ] == 0xFF && h[ 6 ] == 0xFF && h[ 7 ] == 0xFF )
    {
        return 0;
    }
    if ( ( h[ 2 ] & 0x0F ) == 0x0A
         && h[ 4 ] == 0xFF && h[ 5 ] == 0xFF && h[ 6 ] == 0xFF && h[ 7 ] == 0xFF )
    {
        if ( h[ 3 ] >> 4 > 9 || ( h[ 3 ] & 0x0F ) > 9 || h[ 2 ] >> 4 > 9 ) {
            return -2;
        }
        return ( h[ 3 ] >> 4 ) * 100 + ( h[ 3 ] & 0x0F ) * 10 + ( h[ 2 ] >> 4 );
    }
    c[ 0 ] = ( h[ 7 ] & 0xF0 ) | ( h[ 4 ] >> 4 );
    c[ 1 ] = ( h[ 7 ] << 4 & 0xF0 ) | ( h[ 4 ] & 0x0F );
    c[ 2 ] = ( h[ 6 ] & 0xF0 ) | ( h[ 3 ] >> 4 );
    c[ 3 ] = ( h[ 6 ] << 4 & 0xF0 ) | ( h[ 3 ] & 0x0F );
    c[ 4 ] = ( h[ 5 ] & 0xF0 ) | ( h[ 2 ] >> 4 );
    c[ 5 ] = ( h[ 5 ] << 4 & 0xF0 ) | ( h[ 2 ] & 0x0F );

    /*
     *  Names are padded with 0x0F (FX-602P) or blanks (0x7F, simulator)
     */
    for ( i = 0; i < NAME_LEN && ( c[ i ] == 0x0F || c[ i ] == 0x7F ); ++i )
        ;
    for ( n = NAME_LEN; n > i && ( c[ n - 1 ] == 0x0F || c[ n - 1 ] == 0x7F ); --n )
        ;
    for ( *len = 0; i < n; ++i ) {
        codes[ ( *len )++ ] = alphaBit7( c[ i ] );
    }
    return -1;
}


/*
 *  Print the line "# @name" or "# @number" for prg602, nothing if there
 *  is no name
 */
void printName( const int *h )
{
    int codes[ NAME_LEN ];
    int len, i;
    int number = decodeName( h, codes, &len );

    if ( number == -2 ) {
        printf( "# Invalid file number %X%X%X\n", h[ 3 ] >> 4, h[ 3 ] & 0x0F, h[ 2 ] >> 4 );
    }
    else if ( number > 0 ) {
        printf( "# @number %d\n", number );
    }
    else if ( number == -1 ) {
        printf( "# @name \"" );
        for ( i = 0; i < len; ++i ) {
            printAlpha( codes[ i ], 0 );
        }
        printf( "\"\n" );
    }
}


/*
 *  Check if prg602 creates the same header from the lines "# @..."
 *  printed for it, otherwise the line "# @rawheader" is needed
 */
bool isHeaderDescribed( const int *h, bool fx601, const char *file )
{
    int e[ HEADER_LEN ], codes[ NAME_LEN ];
    int len, number, i;

    e[ 0 ] = fx601 ? PARTITION601 : h[ 0 ] >= 0x04 && h[ 0 ] <= 0x40 ? h[ 0 ] : 0x40;
    e[ 1 ] = strcmp( file, "program" ) == 0 ? TYPE_PROGRAM
           : strcmp( file, "all" ) == 0 ? TYPE_ALL : TYPE_DATA;
    number = decodeName( h, codes, &len );
    if ( number == -2 ) {
        return false;
    }
    if ( number >= 0 ) {
        encodeNumber602( e, number );
    }
    else {
        encodeName602( e, codes, len );
    }
    for ( i = 0; i < HEADER_LEN; ++i ) {
        if ( e[ i ] != h[ i ] ) {
            return false;
        }
    }
    return true;
}


/*
 *  Find the next footer (8 bytes 0xFF) at or after start
 *  Returns the position of the footer or end if not found
 */
int findFooter( int start, int end )
{
    int i, n = 0;

    for ( i = start; i < end; ++i ) {
        if ( Data[ i ] == 0xFF ) {
            if ( ++n == FOOTER_LEN ) {
                return i - FOOTER_LEN + 1;
            }
        }
        else {
            n = 0;
        }
    }
    return end;
}


/*
 *  Check for a footer (8 bytes 0xFF) at Data[ pos ]
 */
bool isFooter( int pos, int end )
{
    int i;

    if ( pos + FOOTER_LEN > end ) {
        return false;
    }
    for ( i = pos; i < pos + FOOTER_LEN; ++i ) {
        if ( Data[ i ] != 0xFF ) {
            return false;
        }
    }
    return true;
}


/*
 *  Find the data registers starting at Data[ data ]
 *  count is the number of registers from the memory partition or 0.
 *  Registers may contain 0xFF only, therefore the footer is expected
 *  behind count registers. Otherwise the first footer at a register
 *  boundary terminates the data.
 *  Returns the end of the registers, *after is set behind the footer.
 */
int findRegisters( int data, int count, int end, int *after, bool *footer )
{
    int i;

    if ( count > 0 && isFooter( data + count * REG_LEN, end ) ) {
        *after = data + count * REG_LEN + FOOTER_LEN;
        *footer = true;
        return data + count * REG_LEN;
    }
    for ( i = data; i + REG_LEN <= end; i += REG_LEN ) {
        if ( isFooter( i, end ) ) {
            *after = i + FOOTER_LEN;
            *footer = true;
            return i;
        }
    }
    *after = end;
    *footer = false;
    return i;
}


/*
 *  List a single file starting with the header at Data[ start ]
 *  header_len is less than HEADER_LEN if a part of the header is missing
 *  in a recording.
 *  Returns the position behind the file
 */
int listFile( int start, int header_len, int end )
{
    int h[ HEADER_LEN ];
    int body = start + header_len;
    int footer = findFooter( body, end );
    int after = footer < end ? footer + FOOTER_LEN : end;
    int prog_end = footer;
    int data = after, data_end = after;
    int steps = 0, registers = 0;
    bool data_footer = true;
    bool display_number = false;
    bool display_alpha = false;
    bool display_text = false;
    bool fx601;
    const char *file;
    int i;

    for ( i = 0; i < HEADER_LEN; ++i ) {
        h[ i ] = i < header_len ? Data[ start + i ] : 0xFF;
    }

    /*
     *  Memory partition: steps / 8 in the first header byte,
     *  20..80 registers M00..M79 and one register MF..M7F for each
     *  complete group of ten
     */
    if ( h[ 0 ] >= 0x04 && h[ 0 ] <= 0x40 ) {
        int numbered;

        steps = h[ 0 ] * 8;
        numbered = 20 + ( 512 - steps ) / 8;
        registers = numbered + numbered / 10;
    }

    if ( h[ 1 ] == TYPE_DATA && footer == body + REG_LEN
         && ( isRegister( Data + body ) || isSyntheticRegister( Data + body ) ) )
    {
        /*
         *  Display data (numeric), a single register
         */
        file = "display";
        display_number = true;
        steps = 0;
    }
    else if ( h[ 1 ] == TYPE_DATA && isFooter( body + DISPLAY_LEN, end )
              && registerEnd( body, body + DISPLAY_LEN ) != body + DISPLAY_LEN
              && isDisplayText( Data + body ) )
    {
        /*
         *  Display data (alpha) of the calculator, the padding of the
         *  text may contain 0xFF bytes in front of the footer
         */
        file = "display";
        display_text = true;
        steps = 0;
        footer = prog_end = body + DISPLAY_LEN;
        after = data = data_end = footer + FOOTER_LEN;
    }
    else if ( h[ 1 ] == TYPE_DATA && registerEnd( body, footer ) != footer
              && isAlphaText( body, footer ) )
    {
        /*
         *  Display data (alpha) of the simulator, the text as alpha codes
         */
        file = "display";
        display_alpha = true;
        steps = 0;
    }
    else if ( h[ 1 ] == TYPE_ALL && steps > 0 ) {
        /*
         *  The whole program area, unused steps filled with 0xFF,
         *  a separating 0xFF and all registers
         */
        file = "all";
        prog_end = body + steps < end ? body + steps : end;
        data = prog_end < end && Data[ prog_end ] == 0xFF ? prog_end + 1 : prog_end;
        data_end = findRegisters( data, registers, end, &after, &data_footer );
    }
    else if ( h[ 1 ] != TYPE_PROGRAM && footer > body
              && ( isRegister( Data + body ) || isSyntheticRegister( Data + body ) ) )
    {
        /*
         *  Data registers only
         */
        file = "data";
        data = body;
        prog_end = body;
        data_end = findRegisters( data, registers, end, &after, &data_footer );
    }
    else {
        /*
         *  Program, the simulator by Martin Krischik adds the registers
         *  of an "all" file behind the footer of the program
         */
        int footer2 = findFooter( after, end );

        data_end = registerEnd( after, footer2 );
        if ( data_end > data ) {
            after = footer2 < end ? footer2 + FOOTER_LEN : end;
            data_footer = footer2 < end;
        }
        file = data_end > data ? "all" : "program";
        if ( data_end == data && after < end && Data[ after ] == 0xFF ) {
            /*
             *  The program ends with 0xFF in front of the footer
             */
            ++after;
        }
        if ( h[ 1 ] == TYPE_DATA ) {
            /*
             *  The simulator writes "all" files with type 40 40,
             *  the memory partition is unknown
             */
            steps = 0;
        }
    }

    /*
     *  The FX-601P has 128 steps like the FX-602P with MODE . 68, but
     *  only 16 registers: M00..M09, MF and 5 L registers for parentheses
     */
    fx601 = h[ 0 ] == PARTITION601 && data_end - data == REGISTERS601 * REG_LEN;

    /*
     *  Comment lines with the file description for prg602
     */
    printf( "# @calculator %s\n", fx601 ? "601" : "602" );
    printf( "# @file %s\n", file );
    if ( header_len == HEADER_LEN ) {
        printName( h );
    }
    if ( !fx601 && h[ 0 ] >= 0x04 && h[ 0 ] <= 0x40 ) {
        printf( "# @mode .%d\n", 20 + ( 512 - h[ 0 ] * 8 ) / 8 );
    }
    if ( header_len == HEADER_LEN && !isHeaderDescribed( h, fx601, file ) ) {
        printf( "# @rawheader" );
        for ( i = 0; i < HEADER_LEN; ++i ) {
            printf( " %02X", h[ i ] );
        }
        printf( "\n" );
    }

    /*
     *  Remarks on damaged or unknown files
     */
    if ( header_len < HEADER_LEN ) {
        printf( "# Header incomplete:" );
        for ( i = 0; i < header_len; ++i ) {
            printf( " %02X", h[ i ] );
        }
        printf( "\n" );
    }
    else if ( h[ 1 ] != TYPE_PROGRAM && h[ 1 ] != TYPE_ALL && h[ 1 ] != TYPE_DATA ) {
        printf( "# Unknown file type %02X %02X\n", h[ 0 ], h[ 1 ] );
    }
    printf( "\n" );

    if ( display_number ) {
        printf( "Display = " );
        printNumber( Data + body );
        if ( !isLossless( Data + body ) ) {
            printf( "  [" );
            for ( i = 0; i < REG_LEN; ++i ) {
                printf( i ? " %02X" : "%02X", Data[ body + i ] );
            }
            printf( "]" );
        }
        printf( "\n" );
    }
    else if ( display_text ) {
        int c[ DISPLAY_LEN ];

        decodeDisplay( c, Data + body );
        printf( "Display = \"" );
        for ( i = displayStart( c ); i < DISPLAY_CHARS; ++i ) {
            printAlpha( displayChar( c, i ), 0 );
        }
        printf( "\"" );
        if ( ShowHex || !isDisplayDescribed( c ) ) {
            for ( i = 0; i < DISPLAY_LEN; ++i ) {
                printf( i ? " %02X" : "  [%02X", c[ i ] );
            }
            printf( "]" );
        }
        printf( "\n" );
    }
    else if ( display_alpha ) {
        printf( "Display = \"" );
        for ( i = body; i < footer; ++i ) {
            printAlpha( Data[ i ], 0 );
        }
        printf( "\"\n" );
    }
    else {
        /*
         *  The program ends with the first 0xFF
         */
        for ( i = body; i < prog_end && Data[ i ] != 0xFF; ++i )
            ;
        if ( body < i ) {
            listProgram( body, i );
        }
        if ( data_end > data ) {
            if ( body < i ) {
                printf( "\nData\n\n" );
            }
            if ( fx601 ) {
                listRegisters( data, data + 11 * REG_LEN );
                listParentheses( data, 11, REGISTERS601 );
            }
            else {
                listRegisters( data, data_end );
            }
        }
    }
    if ( prog_end == end ) {
        printf( "\nEnd of file missing\n" );
    }
    else if ( !data_footer ) {
        printf( "\nEnd of data missing\n" );
    }
    return after;
}


/*
 *  Check for the header of an FX-501P/FX-502P file at Data[ pos ]
 */
bool isHeader502( int pos, int end )
{
    int type = Data[ pos + 1 ] >> 4;

    return pos + HEADER502_LEN <= end
        && ( type == TYPE502_PROGRAM || type == TYPE502_DATA )
        && ( Data[ pos + 1 ] & 0x0F ) <= 9
        && ( Data[ pos ] >> 4 ) <= 9 && ( Data[ pos ] & 0x0F ) <= 9;
}


/*
 *  List a file of the FX-501P/FX-502P starting at Data[ start ]
 *
 *  2 header bytes: second and third digit of the file number,
 *                  type (0xB program, 0xF data) and first digit
 *  Program file: the whole program area of 128 (FX-501P) or 256
 *                (FX-502P) steps, unused steps filled with 0xFF,
 *                followed by the footer
 *  Data file: 16 (FX-501P) or 22 (FX-502P) registers, followed by the
 *             footer. The registers are stored in reverse order in groups
 *             of 11: MF, M9..M0, then M.F, M.9..M.0 on the FX-502P. The
 *             FX-501P has only M0..M9 and MF, the 5 other registers are
 *             the L registers for parentheses, which the FA-2 uses for
 *             note codes in the music function. They are listed with
 *             their position in the file. The statistic function of the
 *             FX-501P uses M9 (n), M8 (sum x) and M7 (sum x^2), which are
 *             cleared by SAC.
 *  The program codes are the same as on the FX-602P.
 *  Returns the position behind the file
 */
int listFile502( int start, int end )
{
    int h0 = Data[ start ];
    int h1 = Data[ start + 1 ];
    int body = start + HEADER502_LEN;
    bool program = ( h1 >> 4 ) == TYPE502_PROGRAM;
    const char *model = "FX-501P/FX-502P";
    bool footer;
    int after, prog_end = body, count = 0;

    File502 = true;
    if ( program ) {
        /*
         *  The program ends with the first 0xFF, the unused steps and
         *  the footer follow
         */
        int steps;

        while ( prog_end < end && Data[ prog_end ] != 0xFF ) {
            ++prog_end;
        }
        for ( after = prog_end; after < end && Data[ after ] == 0xFF; ++after )
            ;
        footer = after - prog_end >= FOOTER_LEN;
        steps = after - FOOTER_LEN - body;
        model = !footer ? model : steps == 128 ? "FX-501P"
              : steps == 256 ? "FX-502P" : model;
    }
    else {
        count = ( findRegisters( body, REGISTERS502, end, &after, &footer )
                  - body ) / REG_LEN;
        model = !footer ? model : count == 16 ? "FX-501P"
              : count == 22 ? "FX-502P" : model;
    }

    /*
     *  Comment lines with the file description for prg602
     */
    printf( "# @calculator %s\n", strcmp( model, "FX-501P" ) == 0 ? "501" : "502" );
    printf( "# @file %s\n", program ? "program" : "data" );
    printNumber502( ( h1 & 0x0F ) << 4 | h0 >> 4, h0 << 4 & 0xF0 );
    printf( "\n" );

    if ( program && body < prog_end ) {
        listProgram( body, prog_end );
    }
    if ( !program ) {
        char reg[ 8 ];
        int n;

        /*
         *  List in the order M0..M9, MF, M.0..M.9, M.F
         */
        for ( n = 0; n < count && ( n < 11 || count == REGISTERS502 ); ++n ) {
            int group = n / 11;
            int index = n % 11;
            int pos = group * 11 + 10 - index;

            if ( pos >= count ) {
                continue;
            }
            if ( index < 10 ) {
                sprintf( reg, "%s%d", group ? "." : "", index );
            }
            else {
                sprintf( reg, "%sF", group ? "." : "" );
            }
            printf( "M%-3s = ", reg );
            printRegister( body + pos * REG_LEN );
        }
        if ( n < count ) {
            listParentheses( body, n, count );
        }
    }
    if ( !footer ) {
        printf( "\nEnd of file missing\n" );
    }
    File502 = false;
    return after;
}


/*
 *  Read a binary file into Data[]
 */
bool readBinary( char *name, long skip )
{
    FILE *fp = fopen( name, "rb" );
    int c;

    if ( fp == NULL ) {
        fprintf( stderr, "\nCannot open the file %s\n", name );
        perror( "error" );
        return false;
    }
    while ( ( c = fgetc( fp ) ) != EOF && Count < MAX_BYTES ) {
        if ( skip > 0 ) {
            --skip;
            continue;
        }
        Data[ Count++ ] = c;
    }
    fclose( fp );
    return true;
}


/*
 *  Read a WAV file into Data[]
 */
bool readWave( char *name, bool ignore )
{
    KCS_FILE *wfp = kcsOpen( name, "rb", 300, 8, 'E', 2 );
    int c, errors = 0;

    if ( wfp == NULL ) {
        fprintf( stderr, "\nCannot open the file %s\n", name );
        perror( "error" );
        return false;
    }
    while ( ( c = kcsReadByte( wfp ) ) >= 0 && Count < MAX_BYTES ) {
        if ( c == KCS_LEAD_IN ) {
            if ( Count == 0 || Data[ Count - 1 ] != LEAD_IN ) {
                Data[ Count++ ] = LEAD_IN;
            }
            continue;
        }
        if ( c & ( KCS_FRAMING | KCS_PARITY ) ) {
            ++errors;
            if ( ignore ) {
                continue;
            }
        }
        Data[ Count++ ] = c & 0xFF;
    }
    if ( c != KCS_EOF && c >= 0 ) {
        fprintf( stderr, "File too large\n" );
    }
    else if ( c != KCS_EOF ) {
        perror( "read" );
        kcsClose( wfp );
        return false;
    }
    kcsClose( wfp );
    if ( errors > 0 ) {
        fprintf( stderr, "%d bytes with parity or framing errors%s\n",
                 errors, ignore ? " ignored" : "" );
    }
    return true;
}


/*
 *  Remove the lead-in markers from Data[] and store the file starts
 *  A new file starts after a lead-in, leading 0xFF bytes are skipped.
 */
int findFiles( int *starts, int max )
{
    int i, j, n = 0;
    bool lead_in = true;

    for ( i = j = 0; i < Count; ++i ) {
        if ( Data[ i ] == LEAD_IN ) {
            lead_in = true;
            continue;
        }
        if ( lead_in && Data[ i ] == 0xFF ) {
            continue;
        }
        if ( lead_in && n < max ) {
            starts[ n++ ] = j;
        }
        lead_in = false;
        Data[ j++ ] = Data[ i ];
    }
    Count = j;
    return n;
}


/*
 *  Main entry point
 */
int main( int argc, char **argv )
{
    long skip = 0;
    bool wavemode = false;
    bool ignore = false;
    int starts[ 100 ];
    int files, f, pos;

    while ( argc > 1 && argv[ 1 ][ 0 ] == '-' ) {

        if ( strncmp( argv[ 1 ], "-b", 2 ) == 0 ) {
            wavemode = false;
            skip = atol( argv[ 1 ] + 2 );
        }
        if ( strncmp( argv[ 1 ], "-w", 2 ) == 0 ) {
            wavemode = true;
        }
        if ( strncmp( argv[ 1 ], "-i", 2 ) == 0 ) {
            ignore = true;
        }
        if ( strncmp( argv[ 1 ], "-u", 2 ) == 0 ) {
            Utf8 = true;
        }
        if ( strncmp( argv[ 1 ], "-s", 2 ) == 0 ) {
            ShowSteps = true;
        }
        if ( strncmp( argv[ 1 ], "-x", 2 ) == 0 ) {
            ShowHex = ShowSteps = true;
        }
        ++argv;
        --argc;
    }

    if ( argc <= 1 ) {
        printf( "usage: list602 <options> infile > outfile\n"
                "         -w reads a WAV file directly\n"
                "         -b<skip> reads a binary file, "
                           "<skip> is an optional offset\n"
                "         -i ignores bytes with parity or framing errors\n"
                "         -u uses UTF-8 characters instead of ASCII\n"
                "         -s shows the step numbers\n"
                "         -x shows the hex codes of all steps and the "
                           "step numbers\n" );
        return 2;
    }

    if ( wavemode ? !readWave( argv[ 1 ], ignore )
                  : !readBinary( argv[ 1 ], skip ) )
    {
        return 2;
    }

    files = findFiles( starts, 100 );
    if ( files == 0 || Count - starts[ 0 ] < HEADER_LEN ) {
        printf( "No data found\n" );
        return 1;
    }

    /*
     *  A file may contain lead-ins, e.g. between header and data.
     *  The next file starts with the first lead-in after the footer.
     */
    f = 0;
    pos = starts[ 0 ];
    while ( true ) {
        int next;
        int header_len = HEADER_LEN;

        /*
         *  A lead-in within the header indicates a gap in the recording
         */
        while ( f < files && starts[ f ] <= pos ) {
            ++f;
        }
        if ( f < files && starts[ f ] < pos + HEADER_LEN ) {
            header_len = starts[ f ] - pos;
        }
        if ( isHeader502( pos, Count ) ) {
            pos = listFile502( pos, Count );
        }
        else {
            pos = listFile( pos, header_len, Count );
        }
        while ( f < files && starts[ f ] < pos ) {
            ++f;
        }
        next = f < files ? starts[ f ] : Count;
        if ( next > pos && !wavemode ) {
            fprintf( stderr, "%d bytes after the end of file ignored\n",
                     next - pos );
        }
        if ( Count - next < HEADER_LEN ) {
            break;
        }
        printf( "\n" );
        pos = next;
    }
    return 0;
}
