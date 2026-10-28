/*
 *  prg602.c - Create Casio FX-601P/FX-602P tape files from program text
 *
 *  This program translates a program listing into a tape image of the
 *  FX-601P/FX-602P or FX-501P/FX-502P calculator and writes it as WAV
 *  file, which can be loaded through the FA-1 or FA-2 cassette interface,
 *  or as binary file. The listing has the format created by list602, so a
 *  program can be listed, edited and written back to the calculator.
 *
 *  Options:
 *    -b         create a binary file instead of a WAV file
 *    -n<name>   set the file name (up to 6 characters, FX-601P/FX-602P)
 *    -f<number> set the file number (0..999, 0 for none)
 *    -5         create a file for the FX-502P, -501 for the FX-501P
 *    -l<time>   length of the lead-in in tens of a second (default 50)
 *
 *  Input format:
 *    P0..P9      start a program
 *    steps       one or more per line, separated by blanks, in ASCII or
 *                UTF-8 as listed by list602, e.g. LBL0, MR1F, FIX3, x^2
 *                or x². A step number of 3 digits in front is ignored.
 *    "text"      alpha text with the escapes of list602, e.g. \PI, \ar05
 *    [XX]        a code without name, e.g. from synthetic programming
 *    Password "text" directly after the program marker
 *    # @602, # @502 or # @501 select the calculator: FX-601P/FX-602P,
 *    FX-502P (256 steps) or FX-501P (128 steps). list602 writes this line.
 *    The header line of list602 sets the file type, name or number and
 *    the memory partition, the options take precedence.
 *    Other lines starting with #, empty lines and "No program" are ignored.
 *    The hex codes of list602 -x are not accepted.
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

#define MAX_CODES    0x1000   /* more than any program area */
#define LINE_LEN     1024
#define NAME_LEN     6
#define NAME_PADDING 0x0F     /* fills short names from the left */
#define LEAD_IN_TIME 50       /* tens of a second, as the FX-602P */
#define PARTITION    0x40     /* 512 steps, 22 registers (MODE . 20) */
#define STEPS501     128      /* program area of the FX-501P */
#define STEPS502     256      /* program area of the FX-502P */

/*
 *  Program codes
 */
int Code[ MAX_CODES ];
int Count = 0;

/*
 *  File description from the header line of list602, -1 if not set
 */
int Partition = -1;           /* FX-602P memory partition, header byte 0 */
int Steps502 = -1;            /* FX-501P/FX-502P program area */
int Calculator = -1;          /* 602, 502 or 501 from # @nnn, -1 if not set */
int Number = -1;              /* file number */
int NameCodes[ NAME_LEN ];    /* file name */
int NameLen = -1;
bool HeaderLine = false;      /* header line of list602 found */

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
 *  Returns the number of codes
 */
int alphaText( const char **pp, int *codes, int max, bool registers )
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
     *  Memory operations with register name, e.g. MR05, M+1F, Min25
     */
    for ( op = 0; op < 5; ++op ) {
        const char *names[ 2 ] = { MemoryOps[ op ].ascii, MemoryOps[ op ].utf8 };
        int i;

        for ( i = 0; i < 2; ++i ) {
            int l = names[ i ] != NULL ? (int) strlen( names[ i ] ) : 0;

            if ( l > 0 && l < len && strncasecmp( p, names[ i ], l ) == 0
                 && ( n = parseRegister( p + l, &group, &index ) ) > 0
                 && l + n == len )
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
 *  Parse the header line of list602, e.g.
 *    Program file (type 40 0E), name "AB12XY", 512 steps, 22 registers
 *    Program file (FX-502P, type 23 B1), file number 123
 */
void headerLine( const char *line )
{
    const char *p = line + strlen( "Program file (" );
    unsigned int h0, h1;

    HeaderLine = true;
    if ( strncmp( p, "FX-50", 5 ) == 0 ) {
        Steps502 = strncmp( p, "FX-501P,", 8 ) == 0 ? STEPS501 : STEPS502;
    }
    if ( ( p = strstr( p, "type " ) ) == NULL
         || sscanf( p, "type %x %x", &h0, &h1 ) != 2 )
    {
        error( "File type expected" );
    }
    if ( Steps502 < 0 ) {
        if ( h1 != TYPE_PROGRAM ) {
            error( "Only program files are supported" );
        }
        Partition = (int) h0;
    }
    if ( ( p = strstr( p, "), " ) ) == NULL ) {
        error( "File name or number expected" );
    }
    p += 3;
    if ( strncmp( p, "name ", 5 ) == 0 ) {
        p += 5;
        NameLen = alphaText( &p, NameCodes, NAME_LEN, false );
    }
    else if ( strncmp( p, "file number ", 12 ) == 0 ) {
        Number = atoi( p + 12 );
    }
    else if ( strncmp( p, "no name", 7 ) == 0 ) {
        Number = 0;
    }
    else {
        error( "File name or number expected" );
    }
}


/*
 *  Parse the calculator identifier "# @602", "# @502" or "# @501"
 *  Returns false if the line is no identifier
 */
bool calculatorLine( const char *p )
{
    int calculator;

    if ( *p++ != '#' ) {
        return false;
    }
    while ( *p == ' ' || *p == '\t' ) {
        ++p;
    }
    if ( *p != '@' ) {
        return false;
    }
    calculator = atoi( p + 1 );
    if ( calculator != 602 && calculator != 502 && calculator != 501 ) {
        error( "Unknown calculator \"%.*s\", use @602, @502 or @501",
               fieldLength( p ), p );
    }
    if ( Calculator > 0 && Calculator != calculator ) {
        error( "Calculator @%d does not match @%d", calculator, Calculator );
    }
    Calculator = calculator;
    return true;
}


/*
 *  Translate a line of the listing
 */
void translateLine( char *line )
{
    const char *p = line;
    bool first = true;

    while ( *p == ' ' || *p == '\t' ) {
        ++p;
    }
    if ( calculatorLine( p ) ) {
        return;
    }
    if ( *p == '\0' || *p == '#' || strcmp( p, "No program" ) == 0
         || strncmp( p, "End of ", 7 ) == 0 )
    {
        return;
    }
    if ( strncmp( p, "Program file (", 14 ) == 0 ) {
        headerLine( p );
        return;
    }
    if ( strstr( p, " file (" ) != NULL ) {
        error( "Only program files are supported" );
    }

    while ( *p != '\0' ) {
        int len = fieldLength( p );

        if ( *p == '"' ) {
            /*
             *  Alpha text
             */
            int codes[ LINE_LEN ];
            int n = alphaText( &p, codes, LINE_LEN, true ), i;

            emit( TOKEN_ALPHA );
            for ( i = 0; i < n; ++i ) {
                emit( codes[ i ] );
            }
            emit( TOKEN_ALPHA );
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
            p += len;
            while ( *p == ' ' || *p == '\t' ) {
                ++p;
            }
            n = alphaText( &p, codes, LINE_LEN, false );
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
        while ( *p == ' ' || *p == '\t' ) {
            ++p;
        }
    }
}


/*
 *  Store the file name or number in the header of an FX-601P/FX-602P
 *  file, see printName() in list602.c
 */
void setName602( unsigned char *h )
{
    int c[ NAME_LEN ];
    int i;

    if ( NameLen < 0 ) {
        int d1 = Number / 100, d2 = Number / 10 % 10, d3 = Number % 10;

        h[ 2 ] = (unsigned char) ( d3 << 4 | 0x0A );
        h[ 3 ] = (unsigned char) ( d1 << 4 | d2 );
        memset( h + 4, 0xFF, 4 );
        return;
    }
    /*
     *  Bit 7 is not stored for lower case letters and the codes
     *  0xAA..0xAF, list602 restores it for the codes 0x10..0x2F
     */
    for ( i = 0; i < NAME_LEN; ++i ) {
        c[ i ] = i < NAME_LEN - NameLen ? NAME_PADDING
               : NameCodes[ i - NAME_LEN + NameLen ];
        if ( c[ i ] >= 0x90 && c[ i ] <= 0xAF ) {
            c[ i ] &= 0x7F;
        }
    }
    h[ 2 ] = (unsigned char) ( ( c[ 4 ] & 0x0F ) << 4 | ( c[ 5 ] & 0x0F ) );
    h[ 3 ] = (unsigned char) ( ( c[ 2 ] & 0x0F ) << 4 | ( c[ 3 ] & 0x0F ) );
    h[ 4 ] = (unsigned char) ( ( c[ 0 ] & 0x0F ) << 4 | ( c[ 1 ] & 0x0F ) );
    h[ 5 ] = (unsigned char) ( ( c[ 4 ] & 0xF0 ) | c[ 5 ] >> 4 );
    h[ 6 ] = (unsigned char) ( ( c[ 2 ] & 0xF0 ) | c[ 3 ] >> 4 );
    h[ 7 ] = (unsigned char) ( ( c[ 0 ] & 0xF0 ) | c[ 1 ] >> 4 );
}


/*
 *  Main entry point
 */
int main( int argc, char **argv )
{
    static unsigned char out[ MAX_CODES + 2 * HEADER_LEN + 2 * FOOTER_LEN ];
    bool binary = false;
    int lead_in = LEAD_IN_TIME;
    char *name = NULL;
    char *number = NULL;
    int steps502 = -1;
    char line[ LINE_LEN ];
    FILE *infp;
    int len = 0, i;

    while ( argc > 1 && argv[ 1 ][ 0 ] == '-' ) {

        if ( strcmp( argv[ 1 ], "-b" ) == 0 ) {
            binary = true;
        }
        if ( strncmp( argv[ 1 ], "-n", 2 ) == 0 ) {
            name = argv[ 1 ] + 2;
        }
        if ( strncmp( argv[ 1 ], "-f", 2 ) == 0 ) {
            number = argv[ 1 ] + 2;
        }
        if ( strncmp( argv[ 1 ], "-5", 2 ) == 0 ) {
            steps502 = strcmp( argv[ 1 ], "-501" ) == 0 ? STEPS501 : STEPS502;
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
                "         -n<name> sets the file name (up to 6 characters, "
                           "FX-601P/FX-602P only)\n"
                "         -f<number> sets the file number (0..999, "
                           "0 for none)\n"
                "         -5 creates a file for the FX-502P, "
                           "-501 for the FX-501P\n"
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

    if ( Count == 0 ) {
        error( "No program found" );
    }

    /*
     *  The calculator identifier must match the header line,
     *  the options take precedence over both
     */
    if ( Calculator > 0 ) {
        int steps = Calculator == 501 ? STEPS501 : Calculator == 502 ? STEPS502 : -1;

        if ( HeaderLine && steps != Steps502 ) {
            error( "Calculator @%d does not match the header line", Calculator );
        }
        Steps502 = steps;
    }
    if ( steps502 > 0 ) {
        Steps502 = steps502;
    }
    if ( name != NULL && number != NULL ) {
        error( "Either a name or a number can be set" );
    }
    if ( name != NULL ) {
        const char *p = name;

        if ( Steps502 > 0 ) {
            error( "Files of the FX-501P/FX-502P have no name, "
                   "use -f to set the number" );
        }
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
    if ( Steps502 > 0 && NameLen >= 0 ) {
        error( "Files of the FX-501P/FX-502P have no name" );
    }

    if ( Steps502 > 0 ) {
        /*
         *  FX-501P/FX-502P: 2 header bytes, the whole program area
         */
        if ( Count > Steps502 ) {
            error( "The program has %d steps, the FX-50%cP only %d",
                   Count, Steps502 == STEPS501 ? '1' : '2', Steps502 );
        }
        out[ len++ ] = (unsigned char) ( Number / 10 % 10 << 4 | Number % 10 );
        out[ len++ ] = (unsigned char) ( TYPE502_PROGRAM << 4 | Number / 100 );
        for ( i = 0; i < Steps502; ++i ) {
            out[ len++ ] = (unsigned char) ( i < Count ? Code[ i ] : 0xFF );
        }
    }
    else {
        /*
         *  FX-601P/FX-602P: 8 header bytes, the program ends with 0xFF
         */
        if ( Partition < 0 ) {
            Partition = PARTITION;
        }
        if ( Count > Partition * 8 ) {
            fprintf( stderr, "Warning: the program has %d steps, "
                             "the memory partition only %d\n",
                     Count, Partition * 8 );
        }
        out[ 0 ] = (unsigned char) Partition;
        out[ 1 ] = TYPE_PROGRAM;
        setName602( out );
        len = HEADER_LEN;
        for ( i = 0; i < Count; ++i ) {
            out[ len++ ] = (unsigned char) Code[ i ];
        }
        out[ len++ ] = 0xFF;
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
