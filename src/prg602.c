/*
 *  prg602.c - Create Casio FX-601P/FX-602P tape files from text
 *
 *  This program translates a listing into a tape image of the FX-601P/
 *  FX-602P or FX-501P/FX-502P calculator and writes it as WAV file, which
 *  can be loaded through the FA-1 or FA-2 cassette interface, or as binary
 *  file. The listing has the format created by list602, so programs and
 *  data can be listed, edited and written back to the calculator.
 *
 *  Options:
 *    -b         create a binary file instead of a WAV file
 *    -c<calc>   set the calculator: 602, 601, 502 or 501
 *    -n<name>   set the file name (up to 6 characters, FX-601P/FX-602P)
 *    -f<number> set the file number (0..999, 0 for none)
 *    -l<time>   length of the lead-in in tens of a second (default 50)
 *
 *  Input format:
 *    # @key value  describes the file, the options take precedence:
 *      # @calculator 602, 601, 502 or 501 (default 602)
 *      # @file program, data, all or display (default from the content)
 *      # @name "name" or # @number n (default: no name)
 *      # @mode .nn, the memory partition of the FX-602P (default .20)
 *      # @rawheader XX XX .., all bytes of the header, which replace the
 *        header created from the lines above
 *    P0..P9      start a program
 *    steps       one or more per line, separated by blanks, in ASCII or
 *                UTF-8 as listed by list602, e.g. LBL0, MR1F, FIX3, x^2
 *                or x². A step number of 3 digits in front is ignored.
 *    "text"      alpha text with the escapes of list602, e.g. \PI, \ar05
 *    [XX]        a code without name, e.g. from synthetic programming
 *    Password "text" directly after the program marker
 *    M05 = 1.5   a data register: a number, 8 bytes in brackets, or a
 *                number followed by the bytes as listed by list602 -x.
 *                Names as M00..M99, MF, M1F.., on the FX-501P/FX-502P
 *                also M0..M9, M.0..M.9, M.F, [11]..[15] for the
 *                L registers of the FX-501P/FX-601P.
 *    Display = 55555 or Display = "TEXT", optionally followed by the
 *                16 codes as listed by list602 -x
 *    Other lines starting with #, empty lines and the headings of list602
 *    are ignored. The hex codes of program steps (list602 -x) are not
 *    accepted.
 */
#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdarg.h>
#include <stdbool.h>
#include "wave.h"
#include "fx602.h"

#define MAX_CODES     0x1000  /* more than any program area */
#define MAX_REGISTERS 200     /* register lines in the listing */
#define LINE_LEN      1024
#define LEAD_IN_TIME  50      /* tens of a second, as the FX-602P */
#define MODE          20      /* default memory partition, MODE . 20 */
#define STEPS501      128     /* program area of the FX-501P */
#define STEPS502      256     /* program area of the FX-502P */
#define PARTITION601  0x10    /* FX-601P: 128 steps */
#define REGISTERS601  16      /* FX-501P/FX-601P: M0..M9, MF, 5 L registers */
#define DISPLAY_LEN   16      /* bytes of alpha display data */
#define DISPLAY_CHARS 11      /* characters shown in the display */
#define DISPLAY_FLAG  5       /* bit 7 is set for the sixth character */

/*
 *  File types of # @file
 */
enum { FILE_PROGRAM, FILE_DATA, FILE_ALL, FILE_DISPLAY };
const char *FileTypes[] = { "program", "data", "all", "display" };

/*
 *  A data register from the listing
 */
typedef struct _register {
    int group;                /* tens digit, 1 for M.0..M.F */
    int index;                /* 0..9, 10 for F, -1 for an L register */
    int position;             /* position of an L register [nn] */
    bool raw;                 /* bytes[] given */
    int bytes[ REG_LEN ];
    bool negative;
    char digits[ 11 ];        /* 10 mantissa digits, hex if synthetic */
    int exponent;
    int line;
} REGISTER;

/*
 *  Contents of the listing
 */
int Code[ MAX_CODES ];        /* program codes */
int CodeLine[ MAX_CODES ];    /* line of each code */
int Count = 0;
REGISTER Registers[ MAX_REGISTERS ];
int RegisterCount = 0;
bool DisplayGiven = false;
bool DisplayIsText = false;
REGISTER DisplayNumber;
int DisplayText[ DISPLAY_CHARS ];
int DisplayTextLen = 0;
int DisplayCodes[ DISPLAY_LEN ] = {  /* codes behind the text */
    [ 11 ] = 0xCC, 0x44, 0xE0, 0x00, 0xFF
};
bool DisplayCodesGiven = false;

/*
 *  File description from # @key value, -1 if not set
 */
int Calculator = -1;          /* 602, 601, 502 or 501 */
int FileType = -1;
int Mode = -1;                /* MODE . nn */
int Number = -1;              /* file number */
int NameCodes[ NAME_LEN ];    /* file name */
int NameLen = -1;
int RawHeader[ HEADER_LEN ];  /* header bytes of # @rawheader */
int RawHeaderLen = 0;

int LineNo = 0;


/*
 *  Print an error message with the line number and exit
 */
void error( const char *format, ... )
{
    va_list args;

    if ( LineNo > 0 ) {
        fprintf( stderr, "line %d: ", LineNo );
    }
    va_start( args, format );
    vfprintf( stderr, format, args );
    va_end( args );
    fprintf( stderr, "\n" );
    exit( 1 );
}


/*
 *  Store a code
 */
void emit( int c )
{
    if ( Count >= MAX_CODES ) {
        error( "Program too long" );
    }
    CodeLine[ Count ] = LineNo;
    Code[ Count++ ] = c;
}


/*
 *  Length of a field, which ends with a blank
 */
int fieldLength( const char *p )
{
    int n = 0;

    while ( p[ n ] != '\0' && p[ n ] != ' ' && p[ n ] != '\t' ) {
        ++n;
    }
    return n;
}


/*
 *  Parse a register name: F, nF or nn
 *  Sets the group (tens digit) and the index (0..9, 10 for F)
 *  Returns the number of characters, 0 if there is no register name
 */
int parseRegister( const char *p, int *group, int *index )
{
    if ( p[ 0 ] == 'F' ) {
        *group = 0;
        *index = 10;
        return 1;
    }
    if ( isdigit( (unsigned char) p[ 0 ] ) && p[ 1 ] == 'F' ) {
        *group = p[ 0 ] - '0';
        *index = 10;
        return 2;
    }
    if ( isdigit( (unsigned char) p[ 0 ] ) && isdigit( (unsigned char) p[ 1 ] ) ) {
        *group = p[ 0 ] - '0';
        *index = p[ 1 ] - '0';
        return 2;
    }
    return 0;
}


/*
 *  Parse a register name of the FX-501P/FX-502P: n, .n or .F
 *  Sets the group (1 for .n) and the index (0..9, 10 for F)
 *  Returns the number of characters, 0 if there is no register name
 */
int parseRegister502( const char *p, int *group, int *index )
{
    if ( isdigit( (unsigned char) p[ 0 ] ) ) {
        *group = 0;
        *index = p[ 0 ] - '0';
        return 1;
    }
    if ( p[ 0 ] == '.' && ( isdigit( (unsigned char) p[ 1 ] ) || p[ 1 ] == 'F' ) ) {
        *group = 1;
        *index = p[ 1 ] == 'F' ? 10 : p[ 1 ] - '0';
        return 2;
    }
    return 0;
}


/*
 *  Prefix 0x2C..0x2F for the register groups 2..9, 0 for the groups 0, 1
 */
int registerPrefix( int group )
{
    return group >= 2 ? TOKEN_M20 - 1 + group / 2 : 0;
}


/*
 *  Code of a memory operation (op 0..4: X<->M, Min, MR, M-, M+),
 *  the inverse of memoryName() in list602.c
 */
int memoryCode( int op, int group, int index )
{
    if ( index < 10 ) {
        return ( ( group % 2 ? 0xA : 0x5 ) + op ) << 4 | index;
    }
    return 0xF0 + op + ( group % 2 ? 5 : 0 );
}


/*
 *  Code of an alpha register display (\arXX),
 *  the inverse of alphaRegister() in list602.c
 */
int alphaRegisterCode( int group, int index )
{
    if ( index < 10 ) {
        return ( group % 2 ? 0xB0 : 0x60 ) + index;
    }
    return group % 2 ? 0xF6 : 0xF1;
}


/*
 *  Value of two hex digits at p, -1 if there are none
 */
int hexValue( const char *p )
{
    unsigned int value;

    if ( !isxdigit( (unsigned char) p[ 0 ] ) || !isxdigit( (unsigned char) p[ 1 ] )
         || sscanf( p, "%2x", &value ) != 1 )
    {
        return -1;
    }
    return (int) value;
}


/*
 *  Parse a single alpha character at *pp and advance *pp
 *  *prefix is set to the prefix of a register display or 0
 *  Returns the code, -1 if the character is unknown
 */
int alphaCode( const char **pp, int *prefix )
{
    const char *p = *pp;
    int best = -1, best_len = 0;
    int c, group, index, n;

    *prefix = 0;
    if ( strncmp( p, "\\ar", 3 ) == 0
         && ( n = parseRegister( p + 3, &group, &index ) ) > 0 )
    {
        *prefix = registerPrefix( group );
        *pp = p + 3 + n;
        return alphaRegisterCode( group, index );
    }
    for ( c = 0; c < 256; ++c ) {
        const char *names[ 2 ] = { Alpha[ c ].ascii, Alpha[ c ].utf8 };
        int k;

        for ( k = 0; k < 2; ++k ) {
            int len = names[ k ] != NULL ? (int) strlen( names[ k ] ) : 0;

            if ( len > best_len && strncmp( p, names[ k ], len ) == 0 ) {
                best = c;
                best_len = len;
            }
        }
    }
    if ( best < 0 && p[ 0 ] == '\\' && ( best = hexValue( p + 1 ) ) >= 0 ) {
        best_len = 3;
    }
    *pp = p + best_len;
    return best;
}


/*
 *  Parse an alpha text in quotes at *pp into codes[], advance *pp
 *  With registers, prefixes and register displays are allowed.
 *  With closed, the closing quote may be missing at the end of the line,
 *  *closed is set to false then.
 *  Returns the number of codes
 */
int alphaText( const char **pp, int *codes, int max, bool registers, bool *closed )
{
    const char *p = *pp;
    int n = 0;

    if ( *p != '"' ) {
        error( "Alpha text in quotes expected" );
    }
    ++p;
    while ( *p != '"' ) {
        const char *start = p;
        int prefix, c;

        if ( *p == '\0' && closed != NULL ) {
            *closed = false;
            *pp = p;
            return n;
        }
        if ( *p == '\0' ) {
            error( "Missing quote at the end of the alpha text" );
        }
        if ( ( c = alphaCode( &p, &prefix ) ) < 0 ) {
            error( "Unknown alpha character \"%.*s\"", fieldLength( start ), start );
        }
        if ( !registers && strncmp( start, "\\ar", 3 ) == 0 ) {
            error( "Register display not allowed here" );
        }
        if ( n + ( prefix != 0 ? 2 : 1 ) > max ) {
            error( "Alpha text too long" );
        }
        if ( prefix != 0 ) {
            codes[ n++ ] = prefix;
        }
        codes[ n++ ] = c;
    }
    if ( closed != NULL ) {
        *closed = true;
    }
    *pp = p + 1;
    return n;
}


/*
 *  Translate a single step in the field at p, which has the length len
 *  Returns false if the field is unknown
 */
bool step( const char *p, int len )
{
    int c, op, k, group, index, n;

    if ( len == 2 && p[ 0 ] == 'P' && isdigit( (unsigned char) p[ 1 ] ) ) {
        emit( p[ 1 ] - '0' );
        return true;
    }
    if ( len == 4 && p[ 0 ] == '[' && p[ 3 ] == ']' && hexValue( p + 1 ) >= 0 ) {
        emit( hexValue( p + 1 ) );
        return true;
    }
    if ( len == 4 && strncasecmp( p, "FIX", 3 ) == 0 && isdigit( (unsigned char) p[ 3 ] ) ) {
        emit( TOKEN_M20 );
        emit( 0x10 + p[ 3 ] - '0' );
        return true;
    }

    /*
     *  Names of the standard plane, exact or ignoring the case
     */
    for ( k = 0; k < 2; ++k ) {
        for ( c = 0; c < 256; ++c ) {
            const char *names[ 2 ] = { Tokens[ c ].ascii, Tokens[ c ].utf8 };
            int i;

            for ( i = 0; i < 2; ++i ) {
                if ( names[ i ] != NULL && (int) strlen( names[ i ] ) == len
                     && ( k == 0 ? strncmp( p, names[ i ], len )
                                 : strncasecmp( p, names[ i ], len ) ) == 0 )
                {
                    emit( c );
                    return true;
                }
            }
        }
    }

    /*
     *  Memory operations with register name, e.g. MR05, M+1F, Min25,
     *  or as on the FX-501P/FX-502P, e.g. MR5, M+.F
     */
    for ( op = 0; op < 5; ++op ) {
        const char *names[ 2 ] = { MemoryOps[ op ].ascii, MemoryOps[ op ].utf8 };
        int i;

        for ( i = 0; i < 2; ++i ) {
            int l = names[ i ] != NULL ? (int) strlen( names[ i ] ) : 0;

            if ( l > 0 && l < len && strncasecmp( p, names[ i ], l ) == 0
                 && ( ( ( n = parseRegister( p + l, &group, &index ) ) > 0
                        && l + n == len )
                      || ( ( n = parseRegister502( p + l, &group, &index ) ) > 0
                           && l + n == len ) ) )
            {
                if ( registerPrefix( group ) != 0 ) {
                    emit( registerPrefix( group ) );
                }
                emit( memoryCode( op, group, index ) );
                return true;
            }
        }
    }
    return false;
}


/*
 *  Skip blanks
 */
const char *skipBlanks( const char *p )
{
    while ( *p == ' ' || *p == '\t' ) {
        ++p;
    }
    return p;
}


/*
 *  Parse count hex bytes in brackets, e.g. [00 01 00 00 00 00 00 01]
 *  Returns the position behind the brackets
 */
const char *parseBytes( const char *p, int *bytes, int count )
{
    int i;

    if ( *p++ != '[' ) {
        error( "Bytes in brackets expected" );
    }
    for ( i = 0; i < count; ++i ) {
        if ( i > 0 && *p++ != ' ' ) {
            error( "%d bytes in brackets expected", count );
        }
        if ( ( bytes[ i ] = hexValue( p ) ) < 0 ) {
            error( "%d bytes in brackets expected", count );
        }
        p += 2;
    }
    if ( *p++ != ']' ) {
        error( "%d bytes in brackets expected", count );
    }
    return p;
}


/*
 *  Parse a number as printed by list602, e.g. -2.5 or 1.23456789E-45,
 *  the exponent may also be written as e or without sign. With hex, the
 *  hex digits of a synthetic number are allowed, e.g. 4.0C63D5681E-97,
 *  and the exponent needs the sign.
 *  Returns the position behind the number
 */
const char *parseNumber( const char *p, REGISTER *r, bool hex )
{
    char digits[ 32 ];
    int n = 0, point = -1, exponent = 0;

    r->negative = *p == '-';
    if ( *p == '-' || *p == '+' ) {
        ++p;
    }
    while ( true ) {
        if ( *p == '.' && point < 0 ) {
            point = n;
        }
        else if ( isdigit( (unsigned char) *p )
                  || ( hex && *p >= 'A' && *p <= 'F'
                       && !( *p == 'E' && ( p[ 1 ] == '+' || p[ 1 ] == '-' ) ) ) )
        {
            if ( n == (int) sizeof( digits ) - 1 ) {
                error( "Too many digits" );
            }
            digits[ n++ ] = *p;
        }
        else {
            break;
        }
        ++p;
    }
    if ( n == 0 ) {
        error( "Number expected" );
    }
    if ( *p == 'E' || *p == 'e' ) {
        char *end;

        exponent = (int) strtol( p + 1, &end, 10 );
        if ( end == p + 1 ) {
            error( "Exponent expected" );
        }
        p = end;
    }
    if ( point < 0 ) {
        point = n;
    }

    /*
     *  Normalize: the first digit is not 0
     */
    digits[ n ] = '\0';
    while ( n > 0 && digits[ 0 ] == '0' ) {
        memmove( digits, digits + 1, n-- );
        --point;
    }
    while ( n > 0 && digits[ n - 1 ] == '0' ) {
        digits[ --n ] = '\0';
    }
    if ( n > 10 ) {
        error( "More than 10 digits" );
    }
    r->exponent = exponent + point - 1;
    if ( n == 0 ) {
        r->negative = false;
        r->exponent = 0;
    }
    else if ( r->exponent < -99 || r->exponent > 99 ) {
        error( "Exponent out of range" );
    }
    memset( r->digits, '0', 10 );
    memcpy( r->digits, digits, n );
    r->digits[ 10 ] = '\0';
    return p;
}


/*
 *  Value of a hex digit
 */
int digitValue( char c )
{
    return isdigit( (unsigned char) c ) ? c - '0' : c - 'A' + 10;
}


/*
 *  BCD code of a data register, see printNumber() in list602.c
 *  sign is added to the hundreds digit of the exponent if negative
 */
void encodeRegister( const REGISTER *r, int sign, unsigned char *bytes )
{
    const char *d = r->digits;
    int biased = r->exponent + 100;
    int i;

    if ( r->raw ) {
        for ( i = 0; i < REG_LEN; ++i ) {
            bytes[ i ] = (unsigned char) r->bytes[ i ];
        }
        return;
    }
    if ( d[ 0 ] == '0' ) {
        memset( bytes, 0, REG_LEN );
        return;
    }
    bytes[ 0 ] = (unsigned char) ( biased / 10 % 10 << 4 | biased % 10 );
    bytes[ 1 ] = (unsigned char) ( biased / 100 + ( r->negative ? sign : 0 ) );
    bytes[ 2 ] = (unsigned char) ( digitValue( d[ 9 ] ) << 4 );
    for ( i = 0; i < 4; ++i ) {
        bytes[ 3 + i ] = (unsigned char) ( digitValue( d[ 7 - 2 * i ] ) << 4
                                           | digitValue( d[ 8 - 2 * i ] ) );
    }
    bytes[ 7 ] = (unsigned char) digitValue( d[ 0 ] );
}


/*
 *  Parse the value of a register line: a number as printed by list602 or
 *  8 bytes in brackets, optionally followed by "(synthetic)", which allows
 *  hex digits, and the bytes in brackets of list602 -x, which take
 *  precedence
 */
void parseValue( const char *p, REGISTER *r )
{
    p = skipBlanks( p );
    r->raw = *p == '[';
    if ( r->raw ) {
        p = parseBytes( p, r->bytes, REG_LEN );
    }
    else if ( strchr( p, '[' ) != NULL ) {
        /*
         *  The bytes take precedence, the number is not evaluated
         */
        p = parseBytes( strchr( p, '[' ), r->bytes, REG_LEN );
        r->raw = true;
    }
    else {
        p = skipBlanks( parseNumber( p, r, strstr( p, "(synthetic)" ) != NULL ) );
        if ( strncmp( p, "(synthetic)", 11 ) == 0 ) {
            p = skipBlanks( p + 11 );
        }
    }
    if ( *skipBlanks( p ) != '\0' ) {
        error( "Unexpected \"%s\" behind the value", skipBlanks( p ) );
    }
}


/*
 *  Parse the name of a data register in front of " = "
 *  Returns false if the line is no register line
 */
bool registerName602( const char *p, REGISTER *r )
{
    int len = fieldLength( p );
    const char *q = skipBlanks( p + len );

    if ( len > 0 && p[ len - 1 ] == '=' ) {
        q = p + --len;
    }
    if ( *q != '=' ) {
        return false;
    }
    r->index = r->group = r->position = 0;
    if ( len == 4 && p[ 0 ] == '[' && p[ 3 ] == ']'
         && isdigit( (unsigned char) p[ 1 ] ) && isdigit( (unsigned char) p[ 2 ] ) )
    {
        r->index = -1;
        r->position = ( p[ 1 ] - '0' ) * 10 + p[ 2 ] - '0';
        return true;
    }
    if ( p[ 0 ] != 'M' ) {
        return false;
    }
    if ( len == 3 && p[ 1 ] == '.' ) {
        /*
         *  M.0..M.9, M.F of the FX-502P
         */
        r->group = 1;
        if ( p[ 2 ] == 'F' ) {
            r->index = 10;
            return true;
        }
        r->index = p[ 2 ] - '0';
        return isdigit( (unsigned char) p[ 2 ] );
    }
    if ( len == 2 && isdigit( (unsigned char) p[ 1 ] ) ) {
        /*
         *  M0..M9 of the FX-502P
         */
        r->index = p[ 1 ] - '0';
        return true;
    }
    return len > 1 && parseRegister( p + 1, &r->group, &r->index ) == len - 1;
}


/*
 *  Store a value only once
 */
void setOnce( int *value, int new_value, const char *key )
{
    if ( *value >= 0 && *value != new_value ) {
        error( "@%s is set twice", key );
    }
    *value = new_value;
}


/*
 *  Parse a line "# @key value"
 *  Returns false if the line is no such line
 */
bool directive( const char *p )
{
    const char *key, *value;
    int len, i;

    if ( *p++ != '#' ) {
        return false;
    }
    p = skipBlanks( p );
    if ( *p++ != '@' ) {
        return false;
    }
    key = p;
    len = fieldLength( key );
    value = skipBlanks( key + len );

    if ( len == 10 && strncmp( key, "calculator", len ) == 0 ) {
        int calculator = atoi( value );

        if ( calculator != 602 && calculator != 601
             && calculator != 502 && calculator != 501 )
        {
            error( "Unknown calculator \"%.*s\", use 602, 601, 502 or 501",
                   fieldLength( value ), value );
        }
        setOnce( &Calculator, calculator, "calculator" );
    }
    else if ( len == 4 && strncmp( key, "file", len ) == 0 ) {
        for ( i = 0; i < 4; ++i ) {
            if ( (int) strlen( FileTypes[ i ] ) == fieldLength( value )
                 && strncmp( value, FileTypes[ i ], fieldLength( value ) ) == 0 )
            {
                break;
            }
        }
        if ( i == 4 ) {
            error( "Unknown file type \"%.*s\", use program, data, all or display",
                   fieldLength( value ), value );
        }
        setOnce( &FileType, i, "file" );
    }
    else if ( len == 4 && strncmp( key, "name", len ) == 0 ) {
        if ( NameLen >= 0 || Number >= 0 ) {
            error( "@name or @number is set twice" );
        }
        NameLen = alphaText( &value, NameCodes, NAME_LEN, true, NULL );
    }
    else if ( len == 6 && strncmp( key, "number", len ) == 0 ) {
        char *end;
        long n = strtol( value, &end, 10 );

        if ( end == value || n < 0 || n > 999 ) {
            error( "Invalid file number \"%.*s\"", fieldLength( value ), value );
        }
        if ( NameLen >= 0 || Number >= 0 ) {
            error( "@name or @number is set twice" );
        }
        Number = (int) n;
    }
    else if ( len == 4 && strncmp( key, "mode", len ) == 0 ) {
        char *end;
        long n = strtol( *value == '.' ? value + 1 : value, &end, 10 );

        if ( n < 20 || n > 80 ) {
            error( "Invalid memory partition \"%.*s\", use .20 .. .80",
                   fieldLength( value ), value );
        }
        setOnce( &Mode, (int) n, "mode" );
    }
    else if ( len == 9 && strncmp( key, "rawheader", len ) == 0 ) {
        if ( RawHeaderLen > 0 ) {
            error( "@rawheader is set twice" );
        }
        while ( *value != '\0' ) {
            if ( RawHeaderLen == HEADER_LEN || fieldLength( value ) != 2
                 || ( RawHeader[ RawHeaderLen++ ] = hexValue( value ) ) < 0 )
            {
                error( "Up to %d bytes in hex expected for @rawheader", HEADER_LEN );
            }
            value = skipBlanks( value + 2 );
        }
        if ( RawHeaderLen == 0 ) {
            error( "Bytes in hex expected for @rawheader" );
        }
    }
    else if ( len > 0 && strspn( key, "0123456789" ) == (size_t) len ) {
        error( "Use \"# @calculator %.*s\"", len, key );
    }
    else {
        error( "Unknown key \"@%.*s\"", len, key );
    }
    return true;
}


/*
 *  Parse the display line "Display = 55555" or "Display = "TEXT"",
 *  optionally followed by the 16 codes of list602 -x
 */
void displayLine( const char *p )
{
    if ( DisplayGiven ) {
        error( "Only one display line is allowed" );
    }
    DisplayGiven = true;
    p = skipBlanks( skipBlanks( p ) + 1 );
    if ( *p != '"' ) {
        parseValue( p, &DisplayNumber );
        return;
    }
    DisplayIsText = true;
    DisplayTextLen = alphaText( &p, DisplayText, DISPLAY_CHARS, false, NULL );
    p = skipBlanks( p );
    if ( *p == '[' ) {
        p = parseBytes( p, DisplayCodes, DISPLAY_LEN );
        DisplayCodesGiven = true;
    }
    if ( *skipBlanks( p ) != '\0' ) {
        error( "Unexpected \"%s\" behind the display", skipBlanks( p ) );
    }
}


/*
 *  Skip the hex codes in front of a step as listed by list602 -x:
 *  a step number of 3 digits, 2 blanks and 3 columns "XX ", ".. " or
 *  blanks followed by a blank
 *  Returns the position of the step or p if there are no hex codes
 */
const char *skipHexCodes( const char *p )
{
    const char *q = p + strspn( p, "0123456789" );
    int i;

    if ( q - p != 3 || strncmp( q, "  ", 2 ) != 0 ) {
        return p;
    }
    q += 2;
    for ( i = 0; i < 3; ++i, q += 3 ) {
        if ( strspn( q, "0123456789ABCDEF" ) < 2
             && strncmp( q, "   ", 3 ) != 0
             && !( i == 2 && strncmp( q, ".. ", 3 ) == 0 ) )
        {
            return p;
        }
        if ( q[ 2 ] != ' ' ) {
            return p;
        }
    }
    return *q == ' ' && q[ 1 ] != ' ' && q[ 1 ] != '\0' ? q + 1 : p;
}


/*
 *  Translate a line of the listing
 */
void translateLine( char *line )
{
    const char *p = skipBlanks( line );
    REGISTER r;
    bool first = true;

    if ( directive( p ) ) {
        return;
    }
    if ( *p == '\0' || *p == '#' || strcmp( p, "No program" ) == 0
         || strcmp( p, "Data" ) == 0 || strcmp( p, "L registers (parentheses)" ) == 0
         || strncmp( p, "End of ", 7 ) == 0 )
    {
        return;
    }
    if ( strstr( p, " file (" ) != NULL ) {
        error( "Header line of an older list602, use # @ lines instead" );
    }
    if ( strncmp( p, "Display", 7 ) == 0 && *skipBlanks( p + 7 ) == '=' ) {
        displayLine( p + 7 );
        return;
    }
    if ( registerName602( p, &r ) ) {
        if ( RegisterCount == MAX_REGISTERS ) {
            error( "Too many registers" );
        }
        r.line = LineNo;
        parseValue( strchr( p, '=' ) + 1, &r );
        Registers[ RegisterCount++ ] = r;
        return;
    }

    p = skipHexCodes( p );
    while ( *p != '\0' ) {
        int len = fieldLength( p );

        if ( *p == '"' ) {
            /*
             *  Alpha text
             */
            int codes[ LINE_LEN ];
            bool closed;
            int n = alphaText( &p, codes, LINE_LEN, true, &closed ), i;

            emit( TOKEN_ALPHA );
            for ( i = 0; i < n; ++i ) {
                emit( codes[ i ] );
            }
            if ( closed ) {
                emit( TOKEN_ALPHA );
            }
            else {
                fprintf( stderr, "Warning: line %d: no closing quote, the alpha "
                                 "text is not terminated\n", LineNo );
            }
        }
        else if ( first && len >= 3 && strspn( p, "0123456789" ) == (size_t) len ) {
            /*
             *  Step number
             */
            p += len;
        }
        else if ( len == 8 && strncmp( p, "Password", 8 ) == 0 ) {
            /*
             *  Password in reverse order behind the program marker
             */
            int codes[ LINE_LEN ];
            int n;

            if ( Count == 0 || Code[ Count - 1 ] > 0x09 ) {
                error( "The password must follow the program marker" );
            }
            p = skipBlanks( p + len );
            n = alphaText( &p, codes, LINE_LEN, false, NULL );
            while ( n > 0 ) {
                emit( codes[ --n ] );
            }
            emit( TOKEN_PASSWORD );
        }
        else if ( step( p, len ) ) {
            p += len;
        }
        else {
            error( "Unknown step \"%.*s\"", len, p );
        }
        first = false;
        p = skipBlanks( p );
    }
}


/*
 *  Number of data registers of the calculator
 */
int registerCount( void )
{
    switch ( Calculator ) {
    case 602:
        return Mode + Mode / 10;
    case 502:
        return REGISTERS502;
    default:
        return REGISTERS601;
    }
}


/*
 *  Position of a data register in the file
 *  FX-602P: M00..M09, MF, M10..M19, M1F, ... up to the memory partition
 *  FX-601P: M00..M09, MF, L registers [11]..[15]
 *  FX-502P: MF, M9..M0, M.F, M.9..M.0
 *  FX-501P: MF, M9..M0, L registers [11]..[15]
 */
int registerPosition( const REGISTER *r )
{
    int count = registerCount();
    int pos = -1;

    LineNo = r->line;
    if ( r->index < 0 ) {
        if ( Calculator == 601 || Calculator == 501 ) {
            pos = r->position >= 11 && r->position < count ? r->position : -1;
        }
    }
    else if ( Calculator == 602 ) {
        if ( r->index < 10 ? r->group * 10 + r->index < Mode : r->group < Mode / 10 ) {
            pos = r->group * 11 + r->index;
        }
    }
    else if ( Calculator == 601 ) {
        pos = r->group == 0 ? r->index : -1;
    }
    else if ( r->group <= ( Calculator == 502 ? 1 : 0 ) ) {
        pos = r->group * 11 + 10 - r->index;
    }
    if ( pos < 0 ) {
        error( "The register does not exist on the FX-%dP%s", Calculator,
               Calculator == 602 ? " with this memory partition" : "" );
    }
    return pos;
}


/*
 *  Store the file name or number in the header of an FX-601P/FX-602P
 *  file, see printName() in list602.c
 */
void setName602( unsigned char *out )
{
    int h[ HEADER_LEN ];
    int i;

    if ( NameLen < 0 ) {
        encodeNumber602( h, Number );
    }
    else {
        encodeName602( h, NameCodes, NameLen );
    }
    for ( i = 2; i < HEADER_LEN; ++i ) {
        out[ i ] = (unsigned char) h[ i ];
    }
}


/*
 *  Encode the alpha display data, see decodeDisplay() in list602.c:
 *  the text right aligned and padded with 0x0F, bit 7 of the characters
 *  not stored but set for the sixth one, 5 more codes
 */
void encodeDisplay( unsigned char *p )
{
    int *c = DisplayCodes;
    int i, k;

    if ( !DisplayCodesGiven ) {
        for ( i = 0; i < DISPLAY_CHARS; ++i ) {
            int n = i - ( DISPLAY_CHARS - DisplayTextLen );

            c[ i ] = n < 0 ? NAME_PADDING : DisplayText[ n ] & 0x7F;
        }
        c[ DISPLAY_FLAG ] |= 0x80;
    }
    for ( k = 0; k < 8; ++k ) {
        p[ k ] = (unsigned char) ( ( c[ 14 - 2 * k ] & 0xF0 ) | c[ 15 - 2 * k ] >> 4 );
        p[ k + 8 ] = (unsigned char) ( ( c[ 14 - 2 * k ] << 4 & 0xF0 )
                                       | ( c[ 15 - 2 * k ] & 0x0F ) );
    }
}


/*
 *  Main entry point
 */
int main( int argc, char **argv )
{
    static unsigned char out[ MAX_CODES + MAX_REGISTERS * REG_LEN + 64 ];
    bool binary = false;
    bool fx502;
    int lead_in = LEAD_IN_TIME;
    char *name = NULL;
    char *number = NULL;
    int calculator = -1;
    char line[ LINE_LEN ];
    FILE *infp;
    int len = 0, i;

    while ( argc > 1 && argv[ 1 ][ 0 ] == '-' ) {

        if ( strcmp( argv[ 1 ], "-b" ) == 0 ) {
            binary = true;
        }
        if ( strncmp( argv[ 1 ], "-c", 2 ) == 0 ) {
            calculator = atoi( argv[ 1 ] + 2 );
        }
        if ( strncmp( argv[ 1 ], "-n", 2 ) == 0 ) {
            name = argv[ 1 ] + 2;
        }
        if ( strncmp( argv[ 1 ], "-f", 2 ) == 0 ) {
            number = argv[ 1 ] + 2;
        }
        if ( strncmp( argv[ 1 ], "-l", 2 ) == 0 ) {
            lead_in = atoi( argv[ 1 ] + 2 );
        }
        ++argv;
        --argc;
    }

    if ( argc <= 2 ) {
        printf( "usage: prg602 <options> infile outfile\n"
                "         -b creates a binary file instead of a WAV file\n"
                "         -c<calc> sets the calculator: 602, 601, 502 or 501\n"
                "         -n<name> sets the file name (up to 6 characters, "
                           "FX-601P/FX-602P only)\n"
                "         -f<number> sets the file number (0..999, "
                           "0 for none)\n"
                "         -l<time> length of the lead-in in tens of "
                           "a second (default %d)\n",
                LEAD_IN_TIME );
        return 2;
    }

    if ( ( infp = fopen( argv[ 1 ], "r" ) ) == NULL ) {
        fprintf( stderr, "\nCannot open the file %s\n", argv[ 1 ] );
        perror( "error" );
        return 2;
    }
    while ( fgets( line, LINE_LEN, infp ) != NULL ) {
        ++LineNo;
        line[ strcspn( line, "\r\n" ) ] = '\0';
        translateLine( line );
    }
    fclose( infp );
    LineNo = 0;

    /*
     *  The options take precedence over the listing
     */
    if ( calculator > 0 ) {
        if ( calculator != 602 && calculator != 601
             && calculator != 502 && calculator != 501 )
        {
            error( "Unknown calculator %d, use 602, 601, 502 or 501", calculator );
        }
        Calculator = calculator;
    }
    if ( Calculator < 0 ) {
        Calculator = 602;
    }
    fx502 = Calculator == 502 || Calculator == 501;
    if ( name != NULL && number != NULL ) {
        error( "Either a name or a number can be set" );
    }
    if ( name != NULL ) {
        const char *p = name;

        Number = -1;
        for ( NameLen = 0; *p != '\0'; ++NameLen ) {
            int prefix;

            if ( NameLen == NAME_LEN ) {
                error( "File name \"%s\" too long", name );
            }
            if ( ( NameCodes[ NameLen ] = alphaCode( &p, &prefix ) ) < 0
                 || prefix != 0 )
            {
                error( "Invalid character in file name \"%s\"", name );
            }
        }
    }
    if ( number != NULL ) {
        char *end;
        long n = strtol( number, &end, 10 );

        if ( *number == '\0' || *end != '\0' || n < 0 || n > 999 ) {
            error( "Invalid file number \"%s\"", number );
        }
        Number = (int) n;
        NameLen = -1;
    }
    if ( Number < 0 && NameLen < 0 ) {
        Number = 0;
    }
    /*
     *  The FX-501P/FX-502P have no alpha text, password, FIX and registers
     *  from M20 on. Warn only, as such codes may be synthetic.
     */
    if ( fx502 ) {
        int n = 0, line = 0;

        for ( i = 0; i < Count; ++i ) {
            if ( ( Code[ i ] >= TOKEN_ALPHA && Code[ i ] <= TOKEN_M80 )
                 || Code[ i ] == TOKEN_PASSWORD )
            {
                line = n++ == 0 ? CodeLine[ i ] : line;
            }
        }
        if ( n > 0 ) {
            fprintf( stderr, "Warning: line %d: %d codes of alpha text, password, "
                             "FIX or registers from M20 on, which the FX-%dP "
                             "does not know\n", line, n, Calculator );
        }
    }
    if ( fx502 && NameLen >= 0 ) {
        error( "Files of the FX-501P/FX-502P have no name, use a number" );
    }
    if ( Mode >= 0 && Calculator != 602 ) {
        error( "@mode is only used on the FX-602P" );
    }
    if ( Mode < 0 ) {
        Mode = MODE;
    }

    /*
     *  The file type from the contents
     */
    if ( FileType < 0 ) {
        FileType = DisplayGiven ? FILE_DISPLAY
                 : RegisterCount == 0 ? FILE_PROGRAM
                 : Count == 0 ? FILE_DATA : FILE_ALL;
    }
    if ( ( FileType == FILE_PROGRAM && Count == 0 )
         || ( FileType == FILE_DISPLAY && !DisplayGiven ) )
    {
        error( "No %s found", FileType == FILE_PROGRAM ? "program" : "display" );
    }
    if ( ( FileType != FILE_PROGRAM && FileType != FILE_ALL && Count > 0 )
         || ( ( FileType == FILE_PROGRAM || FileType == FILE_DISPLAY )
              && RegisterCount > 0 )
         || ( FileType != FILE_DISPLAY && DisplayGiven ) )
    {
        error( "The contents do not match the file type %s", FileTypes[ FileType ] );
    }
    if ( fx502 && ( FileType == FILE_ALL || FileType == FILE_DISPLAY ) ) {
        error( "The FX-501P/FX-502P cannot save %s files", FileTypes[ FileType ] );
    }

    /*
     *  Header
     */
    if ( fx502 ) {
        out[ len++ ] = (unsigned char) ( Number / 10 % 10 << 4 | Number % 10 );
        out[ len++ ] = (unsigned char) ( ( FileType == FILE_PROGRAM
                                           ? TYPE502_PROGRAM : TYPE502_DATA ) << 4
                                         | Number / 100 );
    }
    else {
        out[ 0 ] = (unsigned char) ( Calculator == 601 ? PARTITION601 : 84 - Mode );
        out[ 1 ] = (unsigned char) ( FileType == FILE_PROGRAM ? TYPE_PROGRAM
                                   : FileType == FILE_ALL ? TYPE_ALL : TYPE_DATA );
        setName602( out );
        len = HEADER_LEN;
    }

    /*
     *  The raw header replaces the header, the options -n and -f still
     *  take precedence
     */
    if ( RawHeaderLen > 0 ) {
        if ( RawHeaderLen != len ) {
            error( "@rawheader needs %d bytes for the FX-%dP", len, Calculator );
        }
        for ( i = 0; i < len; ++i ) {
            out[ i ] = (unsigned char) RawHeader[ i ];
        }
        if ( !fx502 && ( name != NULL || number != NULL ) ) {
            setName602( out );
        }
        else if ( fx502 && number != NULL ) {
            out[ 0 ] = (unsigned char) ( Number / 10 % 10 << 4 | Number % 10 );
            out[ 1 ] = (unsigned char) ( ( out[ 1 ] & 0xF0 ) | Number / 100 );
        }
    }

    /*
     *  Program: FX-501P/FX-502P the whole program area, FX-601P/FX-602P
     *  terminated by 0xFF, in an "all" file the whole program area
     */
    if ( FileType == FILE_PROGRAM || FileType == FILE_ALL ) {
        int steps = Calculator == 501 ? STEPS501 : Calculator == 502 ? STEPS502
                  : out[ 0 ] * 8;

        if ( Count > steps ) {
            fprintf( stderr, "%s: the program has %d steps, the program area "
                             "of the FX-%dP only %d\n",
                     fx502 || FileType == FILE_ALL ? "Error" : "Warning",
                     Count, Calculator, steps );
            if ( fx502 || FileType == FILE_ALL ) {
                return 1;
            }
        }
        for ( i = 0; i < Count; ++i ) {
            out[ len++ ] = (unsigned char) Code[ i ];
        }
        if ( fx502 || FileType == FILE_ALL ) {
            for ( ; i < steps; ++i ) {
                out[ len++ ] = 0xFF;
            }
        }
        if ( !fx502 ) {
            out[ len++ ] = 0xFF;
        }
    }

    /*
     *  Data registers, unlisted registers are 0
     */
    if ( FileType == FILE_DATA || FileType == FILE_ALL ) {
        int count = registerCount();

        memset( out + len, 0, count * REG_LEN );
        for ( i = 0; i < RegisterCount; ++i ) {
            encodeRegister( &Registers[ i ], fx502 ? 8 : 5,
                            out + len + registerPosition( &Registers[ i ] ) * REG_LEN );
        }
        LineNo = 0;
        len += count * REG_LEN;
    }

    /*
     *  Display data: a number or the alpha text
     */
    if ( FileType == FILE_DISPLAY ) {
        if ( DisplayIsText ) {
            encodeDisplay( out + len );
            len += DISPLAY_LEN;
        }
        else {
            encodeRegister( &DisplayNumber, 5, out + len );
            len += REG_LEN;
        }
    }
    memset( out + len, 0xFF, FOOTER_LEN );
    len += FOOTER_LEN;

    if ( binary ) {
        FILE *outfp = fopen( argv[ 2 ], "wb" );

        if ( outfp == NULL || fwrite( out, 1, len, outfp ) != (size_t) len
             || fclose( outfp ) != 0 )
        {
            fprintf( stderr, "\nCannot write the file %s\n", argv[ 2 ] );
            perror( "error" );
            return 2;
        }
    }
    else {
        KCS_FILE *kcs = kcsOpen( argv[ 2 ], "wb", 300, 8, 'E', 2 );

        if ( kcs == NULL ) {
            fprintf( stderr, "\nCannot create the file %s\n", argv[ 2 ] );
            perror( "error" );
            return 2;
        }
        if ( 0 != kcsLeadIn( kcs, lead_in ) ) {
            perror( "write" );
            return 2;
        }
        for ( i = 0; i < len; ++i ) {
            if ( 0 != kcsWriteByte( kcs, out[ i ] ) ) {
                perror( "write" );
                return 2;
            }
        }
        /*
         *  Short leader for termination
         */
        kcsLeadIn( kcs, 1 );
        kcsClose( kcs );
    }
    return 0;
}
