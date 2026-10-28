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
 *    -x       show the hex codes of all steps
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

#define MAX_BYTES  0x10000    /* more than any tape file */
#define LEAD_IN    -1         /* lead-in marker in the input buffer */
#define HEADER_LEN 8
#define FOOTER_LEN 8          /* number of 0xFF bytes */
#define REG_LEN    8          /* bytes per data register */
#define DISPLAY_LEN   16      /* bytes of alpha display data */
#define DISPLAY_CHARS 11      /* characters shown in the display */

#define TYPE502_PROGRAM 0xB   /* FX-502P file types, high nibble of byte 1 */
#define TYPE502_DATA    0xF
#define HEADER502_LEN   2
#define REGISTERS502    22

#define TOKEN_ALPHA     0x2B  /* starts and ends alpha mode */
#define TOKEN_M20       0x2C  /* prefix for M20..M39 and FIX */
#define TOKEN_M80       0x2F  /* prefix for M80..M99 (synthetic) */
#define TOKEN_PASSWORD  0xEC  /* terminates the password */

/*
 *  Options
 */
bool Utf8 = false;
bool ShowHex = false;

/*
 *  Input buffer, filled by the reading routines
 */
int Data[ MAX_BYTES ];
int Count = 0;

/*
 *  Names in ASCII and UTF-8
 */
typedef struct _name {
    const char *ascii;
    const char *utf8;
} NAME;

#define NAME_OF( n ) ( Utf8 && ( n ).utf8 != NULL ? ( n ).utf8 : ( n ).ascii )

/*
 *  Standard plane
 *  The memory operations 0x50..0xE9 (columns 0..9) and 0xF0..0xF9
 *  are handled by memoryName() and are left out here.
 *  NULL marks unknown or synthetic codes.
 */
const NAME Tokens[ 256 ] = {
    /* 0x00..0x09: program markers P0..P9, handled separately */
    [ 0x0A ] = { "0" },        [ 0x0B ] = { "1" },
    [ 0x0C ] = { "2" },        [ 0x0D ] = { "3" },
    [ 0x0E ] = { "." },        [ 0x0F ] = { "EXP" },
    [ 0x10 ] = { "RND0" },     [ 0x11 ] = { "RND1" },
    [ 0x12 ] = { "RND2" },     [ 0x13 ] = { "RND3" },
    [ 0x14 ] = { "RND4" },     [ 0x15 ] = { "RND5" },
    [ 0x16 ] = { "RND6" },     [ 0x17 ] = { "RND7" },
    [ 0x18 ] = { "RND8" },     [ 0x19 ] = { "RND9" },
    [ 0x1A ] = { "4" },        [ 0x1B ] = { "5" },
    [ 0x1C ] = { "6" },        [ 0x1D ] = { "7" },
    [ 0x1E ] = { "8" },        [ 0x1F ] = { "9" },
    [ 0x20 ] = { "LBL0" },     [ 0x21 ] = { "LBL1" },
    [ 0x22 ] = { "LBL2" },     [ 0x23 ] = { "LBL3" },
    [ 0x24 ] = { "LBL4" },     [ 0x25 ] = { "LBL5" },
    [ 0x26 ] = { "LBL6" },     [ 0x27 ] = { "LBL7" },
    [ 0x28 ] = { "LBL8" },     [ 0x29 ] = { "LBL9" },
    [ 0x2A ] = { "HLT" },
    /* 0x2B: alpha mode, 0x2C..0x2F: prefixes, handled separately */
    [ 0x30 ] = { "GOTO0" },    [ 0x31 ] = { "GOTO1" },
    [ 0x32 ] = { "GOTO2" },    [ 0x33 ] = { "GOTO3" },
    [ 0x34 ] = { "GOTO4" },    [ 0x35 ] = { "GOTO5" },
    [ 0x36 ] = { "GOTO6" },    [ 0x37 ] = { "GOTO7" },
    [ 0x38 ] = { "GOTO8" },    [ 0x39 ] = { "GOTO9" },
    [ 0x3A ] = { "xD" },
    [ 0x3C ] = { "ENG" },      [ 0x3D ] = { "DMS", "\xC2\xB0'\"" },
    [ 0x3E ] = { "log" },      [ 0x3F ] = { "ln" },
    [ 0x40 ] = { "GSBP0" },    [ 0x41 ] = { "GSBP1" },
    [ 0x42 ] = { "GSBP2" },    [ 0x43 ] = { "GSBP3" },
    [ 0x44 ] = { "GSBP4" },    [ 0x45 ] = { "GSBP5" },
    [ 0x46 ] = { "GSBP6" },    [ 0x47 ] = { "GSBP7" },
    [ 0x48 ] = { "GSBP8" },    [ 0x49 ] = { "GSBP9" },
    [ 0x4A ] = { "+/-" },      [ 0x4B ] = { "(" },
    [ 0x4C ] = { ")" },        [ 0x4D ] = { "sin" },
    [ 0x4E ] = { "cos" },      [ 0x4F ] = { "tan" },
    [ 0x5A ] = { "*", "\xC3\x97" }, [ 0x5B ] = { "/", "\xC3\xB7" },
    [ 0x5C ] = { "+" },        [ 0x5D ] = { "-" },
    [ 0x5E ] = { "=" },        [ 0x5F ] = { "EXE" },
    [ 0x6B ] = { "DSZ" },      [ 0x6C ] = { "x=0" },
    [ 0x6D ] = { "x=F" },      [ 0x6E ] = { "RAN#" },
    [ 0x6F ] = { "PI", "\xCF\x80" },
    [ 0x7A ] = { "ISZ" },      [ 0x7B ] = { "x>=0", "x\xE2\x89\xA5" "0" },
    [ 0x7C ] = { "x>=F", "x\xE2\x89\xA5" "F" },
    [ 0x7D ] = { "xbar", "x\xCC\x84" },
    [ 0x7E ] = { "sdn", "\xCF\x83n" },
    [ 0x7F ] = { "sdn-1", "\xCF\x83n-1" },
    [ 0x8A ] = { "PAUSE" },    [ 0x8B ] = { "IND" },
    [ 0x8C ] = { "SAVE" },     [ 0x8D ] = { "LOAD" },
    [ 0x8E ] = { "MAC" },      [ 0x8F ] = { "SAC" },
    [ 0x9A ] = { "xDEL" },
    [ 0x9C ] = { "ENG<-", "ENG\xE2\x86\x90" },
    [ 0x9D ] = { "DMS<-", "\xC2\xB0'\"\xE2\x86\x90" },
    [ 0x9E ] = { "10^x", "10\xCB\xA3" },
    [ 0x9F ] = { "e^x", "e\xCB\xA3" },
    [ 0xAA ] = { "ABS" },      [ 0xAB ] = { "INT" },
    [ 0xAC ] = { "FRAC" },
    [ 0xAD ] = { "sin-1", "sin\xE2\x81\xBB\xC2\xB9" },
    [ 0xAE ] = { "cos-1", "cos\xE2\x81\xBB\xC2\xB9" },
    [ 0xAF ] = { "tan-1", "tan\xE2\x81\xBB\xC2\xB9" },
    [ 0xBA ] = { "x^y", "x\xCA\xB8" },
    [ 0xBB ] = { "x^(1/y)", "x\xC2\xB9\xE1\x90\x9F\xCA\xB8" },
    [ 0xBC ] = { "R->P", "R\xE2\x86\x92P" },
    [ 0xBD ] = { "P->R", "P\xE2\x86\x92R" },
    [ 0xBE ] = { "%" },        [ 0xBF ] = { "invEXE" },
    [ 0xCA ] = { "GSBP(0)" },
    [ 0xCB ] = { "X<->Y", "X\xE2\x86\x94Y" },
    [ 0xCC ] = { "SQR", "\xE2\x88\x9A" },
    [ 0xCD ] = { "x^2", "x\xC2\xB2" },
    [ 0xCE ] = { "1/x" },      [ 0xCF ] = { "x!" },
    [ 0xDA ] = { "DEG" },      [ 0xDB ] = { "RAD" },
    [ 0xDC ] = { "GRA" },      [ 0xDD ] = { "sinh" },
    [ 0xDE ] = { "cosh" },     [ 0xDF ] = { "tanh" },
    [ 0xED ] = { "sinh-1", "sinh\xE2\x81\xBB\xC2\xB9" },
    [ 0xEE ] = { "cosh-1", "cosh\xE2\x81\xBB\xC2\xB9" },
    [ 0xEF ] = { "tanh-1", "tanh\xE2\x81\xBB\xC2\xB9" },
    [ 0xFA ] = { "AC" },
};

/*
 *  Memory operations, rows 5..9 and A..E of the standard plane
 */
const NAME MemoryOps[ 5 ] = {
    { "X<->M", "X\xE2\x86\x94M" }, { "Min" }, { "MR" }, { "M-" }, { "M+" }
};

/*
 *  Alpha plane, between two 0x2B tokens
 *  The display of register contents (0x60..0x69, 0xB0..0xB9, 0xF1, 0xF6)
 *  is handled by alphaRegister() and left out here.
 *  Backslash escapes in ASCII mode for characters without ASCII
 *  equivalent, NULL marks unknown codes.
 */
const NAME Alpha[ 256 ] = {
    [ 0x30 ] = { "A" }, [ 0x31 ] = { "B" }, [ 0x32 ] = { "C" },
    [ 0x33 ] = { "D" }, [ 0x34 ] = { "E" }, [ 0x35 ] = { "F" },
    [ 0x36 ] = { "G" }, [ 0x37 ] = { "H" }, [ 0x38 ] = { "I" },
    [ 0x39 ] = { "J" }, [ 0x3A ] = { "K" }, [ 0x3B ] = { "L" },
    [ 0x3C ] = { "M" }, [ 0x3D ] = { "N" }, [ 0x3E ] = { "O" },
    [ 0x3F ] = { "P" }, [ 0x40 ] = { "Q" }, [ 0x41 ] = { "R" },
    [ 0x42 ] = { "S" }, [ 0x43 ] = { "T" }, [ 0x44 ] = { "U" },
    [ 0x45 ] = { "V" }, [ 0x46 ] = { "W" }, [ 0x47 ] = { "X" },
    [ 0x48 ] = { "Y" }, [ 0x49 ] = { "Z" },
    [ 0x4A ] = { "\\*", "\xC3\x97" }, [ 0x4B ] = { "\\:", "\xC3\xB7" },
    [ 0x4C ] = { "+" }, [ 0x4D ] = { "-" }, [ 0x4E ] = { "=" },
    [ 0x50 ] = { ":" }, [ 0x51 ] = { "\\#", "\xE2\x96\x88" },
    [ 0x52 ] = { "?" }, [ 0x53 ] = { "!" },
    [ 0x54 ] = { "\\MU", "\xC2\xB5" },
    [ 0x55 ] = { "{" }, [ 0x56 ] = { "}" },
    [ 0x57 ] = { "\\SM", "\xCE\xA3" },
    [ 0x58 ] = { "(" }, [ 0x59 ] = { ")" }, [ 0x5A ] = { "," },
    [ 0x5B ] = { "\\PI", "\xCF\x80" },
    [ 0x5C ] = { "\\EX", "\xE1\xB4\x87" },
    [ 0x5D ] = { ";" }, [ 0x5E ] = { "#" },
    [ 0x70 ] = { "0" }, [ 0x71 ] = { "1" }, [ 0x72 ] = { "2" },
    [ 0x73 ] = { "3" }, [ 0x74 ] = { "4" }, [ 0x75 ] = { "5" },
    [ 0x76 ] = { "6" }, [ 0x77 ] = { "7" }, [ 0x78 ] = { "8" },
    [ 0x79 ] = { "9" }, [ 0x7A ] = { "." },
    [ 0x7B ] = { "\\\"", "\\\"" }, [ 0x7C ] = { "'" },
    [ 0x7D ] = { "\\DG", "\xC2\xB0" }, [ 0x7F ] = { " " },
    [ 0x90 ] = { "a" }, [ 0x91 ] = { "b" }, [ 0x92 ] = { "c" },
    [ 0x93 ] = { "d" }, [ 0x94 ] = { "e" }, [ 0x95 ] = { "f" },
    [ 0x96 ] = { "g" }, [ 0x97 ] = { "h" }, [ 0x98 ] = { "i" },
    [ 0x99 ] = { "j" }, [ 0x9A ] = { "k" }, [ 0x9B ] = { "l" },
    [ 0x9C ] = { "m" }, [ 0x9D ] = { "n" }, [ 0x9E ] = { "o" },
    [ 0x9F ] = { "p" }, [ 0xA0 ] = { "q" }, [ 0xA1 ] = { "r" },
    [ 0xA2 ] = { "s" }, [ 0xA3 ] = { "t" }, [ 0xA4 ] = { "u" },
    [ 0xA5 ] = { "v" }, [ 0xA6 ] = { "w" }, [ 0xA7 ] = { "x" },
    [ 0xA8 ] = { "y" }, [ 0xA9 ] = { "z" },
    [ 0xAA ] = { "*" }, [ 0xAB ] = { "/" },
    [ 0xAC ] = { "\\->", "\xE2\x86\x92" }, [ 0xAD ] = { "\\<-", "\xE2\x86\x90" },
    [ 0xAE ] = { "%" }, [ 0xAF ] = { "\\<>", "\xE2\x86\x94" },
};

/*
 *  File types, second header byte
 *  The first header byte holds the number of program steps divided by 8,
 *  which is selected together with the number of registers by MODE . 20
 *  to MODE . 80, e.g. 0x40 for 512 steps and 22 registers (MODE . 20) or
 *  0x21 for 264 steps and 56 registers M00..M50, MF..M4F (MODE . 51).
 *  Display data files have the type 0x40 like data files, but contain
 *  only the displayed number as one register or the alpha text.
 */
#define TYPE_PROGRAM 0x0E
#define TYPE_ALL     0x1F
#define TYPE_DATA    0x40


/*
 *  Name of a memory register
 *  Registers 0..9 of each group of ten are named M00..M99,
 *  the eleventh register of each group is MF, M1F, M2F, ...
 */
void registerName( char *buffer, int group, int index )
{
    if ( index < 10 ) {
        sprintf( buffer, "%d%d", group, index );
    }
    else if ( group == 0 ) {
        strcpy( buffer, "F" );
    }
    else {
        sprintf( buffer, "%dF", group );
    }
}


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
    registerName( reg, group, index );
    sprintf( buffer, "%s%s", NAME_OF( MemoryOps[ op ] ), reg );
    return true;
}


/*
 *  Name of an alpha register display (arXX) including the prefix offset
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
    else {
        return false;
    }
    sprintf( buffer, "\\ar%s", reg );
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
             && !( Data[ i ] >= TOKEN_M20 && Data[ i ] <= TOKEN_M80 ) )
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
    if ( ShowHex && ( isRegister( Data + i ) || isSyntheticRegister( Data + i ) ) ) {
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
 *  Print the step number and the hex codes of a step
 */
void stepStart( int step, int start, int length )
{
    int i;

    printf( "  %03d  ", step );
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
             *  A password may follow the program marker:
             *  alpha characters in reverse order, terminated by 0xEC.
             *  Each program has its own password.
             */
            for ( j = i; j < end && j < i + 9; ++j ) {
                if ( Data[ j ] == TOKEN_PASSWORD || Alpha[ Data[ j ] ].ascii == NULL ) {
                    break;
                }
            }
            if ( j < end && j > i && Data[ j ] == TOKEN_PASSWORD ) {
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
             *  the register groups of arXX.
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
                if ( Data[ i ] >= TOKEN_M20 && Data[ i ] <= TOKEN_M80 ) {
                    offset = ( Data[ i ] - TOKEN_M20 + 1 ) * 20;
                    ++step;
                    continue;
                }
                printAlpha( Data[ i ], offset );
                offset = 0;
                ++step;
            }
            printf( "\"\n" );
            if ( i < end ) {
                /*
                 *  Closing 0x2B
                 */
                ++step;
                ++i;
            }
            continue;
        }

        if ( c >= TOKEN_M20 && c <= TOKEN_M80 && i + 1 < end ) {
            /*
             *  Prefix for the registers M20..M99 or FIX
             */
            int offset = ( c - TOKEN_M20 + 1 ) * 20;
            int t = Data[ i + 1 ];

            if ( memoryName( buffer, t, offset ) ) {
                stepStart( ++step, i, 2 );
                printf( "%s\n", buffer );
                ++step;
                i += 2;
                continue;
            }
            if ( c == TOKEN_M20 && t >= 0x10 && t <= 0x19 ) {
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
 *  Decode the file name or number from the header
 *
 *  File number (FX-502P, FX-602P): header[ 2 ] = last digit and 0xA,
 *                                  header[ 3 ] = first and second digit,
 *                                  header[ 4..7 ] = 0xFF
 *  The file number 000 is used if no name or number is entered.
 *  FX-602P file name: 6 alpha characters without bit 7, nibbles spread
 *                     over the bytes 2..7
 */
void printName( const int *h )
{
    int c[ 6 ];
    int i, n;

    if ( h[ 2 ] == 0xFF && h[ 3 ] == 0xFF && h[ 4 ] == 0xFF
         && h[ 5 ] == 0xFF && h[ 6 ] == 0xFF && h[ 7 ] == 0xFF )
    {
        printf( "no name" );
        return;
    }
    if ( ( h[ 2 ] & 0x0F ) == 0x0A
         && h[ 4 ] == 0xFF && h[ 5 ] == 0xFF && h[ 6 ] == 0xFF && h[ 7 ] == 0xFF )
    {
        if ( h[ 2 ] == 0x0A && h[ 3 ] == 0x00 ) {
            printf( "no name" );
            return;
        }
        printf( "file number %X%X%X",
                h[ 3 ] >> 4, h[ 3 ] & 0x0F, h[ 2 ] >> 4 );
        return;
    }
    c[ 0 ] = ( h[ 7 ] & 0xF0 ) | ( h[ 4 ] >> 4 );
    c[ 1 ] = ( h[ 7 ] << 4 & 0xF0 ) | ( h[ 4 ] & 0x0F );
    c[ 2 ] = ( h[ 6 ] & 0xF0 ) | ( h[ 3 ] >> 4 );
    c[ 3 ] = ( h[ 6 ] << 4 & 0xF0 ) | ( h[ 3 ] & 0x0F );
    c[ 4 ] = ( h[ 5 ] & 0xF0 ) | ( h[ 2 ] >> 4 );
    c[ 5 ] = ( h[ 5 ] << 4 & 0xF0 ) | ( h[ 2 ] & 0x0F );

    for ( i = 0; i < 6; ++i ) {
        c[ i ] = alphaBit7( c[ i ] );
    }

    /*
     *  Names are padded with 0x0F (FX-602P) or blanks (0x7F, simulator)
     */
    for ( i = 0; i < 6 && ( c[ i ] == 0x0F || c[ i ] == 0x7F ); ++i )
        ;
    for ( n = 6; n > i && ( c[ n - 1 ] == 0x0F || c[ n - 1 ] == 0x7F ); --n )
        ;
    printf( "name \"" );
    for ( ; i < n; ++i ) {
        printAlpha( c[ i ], 0 );
    }
    printf( "\"" );
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
    const char *content;
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
        content = "Display data (numeric)";
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
        content = "Display data (alpha)";
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
        content = "Display data (alpha)";
        display_alpha = true;
        steps = 0;
    }
    else if ( h[ 1 ] == TYPE_ALL && steps > 0 ) {
        /*
         *  The whole program area, unused steps filled with 0xFF,
         *  a separating 0xFF and all registers
         */
        content = "All (programs and data)";
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
        content = "Data";
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
        content = data_end > data ? "All (programs and data)" : "Program";
        if ( h[ 1 ] == TYPE_DATA ) {
            /*
             *  The simulator writes "all" files with type 40 40,
             *  the memory partition is unknown
             */
            steps = 0;
        }
    }

    printf( "%s file (type %02X %02X%s), ", content, h[ 0 ], h[ 1 ],
            h[ 1 ] != TYPE_PROGRAM && h[ 1 ] != TYPE_ALL && h[ 1 ] != TYPE_DATA
            ? ", unknown" : "" );
    if ( header_len < HEADER_LEN ) {
        printf( "header incomplete:" );
        for ( i = 0; i < header_len; ++i ) {
            printf( " %02X", h[ i ] );
        }
    }
    else {
        printName( h );
    }
    if ( steps > 0 ) {
        printf( ", %d steps, %d registers", steps, registers );
    }
    printf( "\n\n" );

    if ( display_number ) {
        printf( "Display = " );
        printNumber( Data + body );
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
        if ( ShowHex ) {
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
            listRegisters( data, data_end );
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
 *             their position in the file.
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

    printf( "%s file (%s, type %02X %02X), ",
            program ? "Program" : "Data", model, h0, h1 );
    if ( h0 == 0x00 && h1 == ( program ? 0xB0 : 0xF0 ) ) {
        printf( "no name\n\n" );
    }
    else {
        printf( "file number %X%X%X\n\n", h1 & 0x0F, h0 >> 4, h0 & 0x0F );
    }

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
            /*
             *  L registers of the FX-501P
             */
            printf( "\nL registers (parentheses)\n\n" );
            for ( ; n < count; ++n ) {
                printf( "[%02d] = ", n );
                printRegister( body + n * REG_LEN );
            }
        }
    }
    if ( !footer ) {
        printf( "\nEnd of file missing\n" );
    }
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
        if ( strncmp( argv[ 1 ], "-x", 2 ) == 0 ) {
            ShowHex = true;
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
                "         -x shows the hex codes of all steps\n" );
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
