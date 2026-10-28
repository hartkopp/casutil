/*
 *  wave602.c - Create Casio FX-601P/FX-602P tape WAV files
 *
 *  This program creates a WAV file from a tape image of the FX-601P or
 *  FX-602P calculator, which can be loaded through the FA-1 or FA-2
 *  cassette interface. The binary file contains the 8 header bytes,
 *  the programs or registers and the footer, e.g. as created by
 *  "wav2raw -b" or by the FX-602P simulator by Martin Krischik.
 *  Files of the FX-501P/FX-502P with their 2 header bytes are supported
 *  as well, the format is detected from the header.
 *
 *  Options:
 *    -b<skip>   read BIN file (Default); skip <skip> garbage bytes
 *    -n<name>   set the file name in the header (up to 6 characters,
 *               FX-601P/FX-602P only)
 *    -f<number> set the file number in the header (0..999, 0 for none)
 *    -l<time>   length of the lead-in in tens of a second (default 50)
 *
 *  See list602.c for the file format.
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include "wave.h"

#define MAX_BYTES    0x10000
#define HEADER_LEN   8
#define NAME_LEN     6
#define LEAD_IN_TIME 50       /* tens of a second, as the FX-602P */
#define NAME_PADDING 0x0F     /* fills short names from the left */

#define TYPE602_PROGRAM 0x0E  /* FX-602P file types, header byte 1 */
#define TYPE602_ALL     0x1F
#define TYPE602_DATA    0x40
#define TYPE502_PROGRAM 0xB   /* FX-502P file types, high nibble of byte 1 */
#define TYPE502_DATA    0xF

/*
 *  Characters allowed in file names and their alpha codes
 */
const struct _alpha {
    char c;
    unsigned char code;
} Alpha[] = {
    { '+', 0x4C }, { '-', 0x4D }, { '=', 0x4E }, { ':', 0x50 },
    { '?', 0x52 }, { '!', 0x53 }, { '{', 0x55 }, { '}', 0x56 },
    { '(', 0x58 }, { ')', 0x59 }, { ',', 0x5A }, { ';', 0x5D },
    { '#', 0x5E }, { '.', 0x7A }, { '\'', 0x7C }, { ' ', 0x7F },
    { '*', 0xAA }, { '/', 0xAB }, { '%', 0xAE }, { '\0', 0x00 }
};

unsigned char Data[ MAX_BYTES ];


/*
 *  Alpha code of a character, 0 if not allowed
 */
int alphaCode( char c )
{
    int i;

    if ( c >= 'A' && c <= 'Z' ) {
        return 0x30 + c - 'A';
    }
    if ( c >= 'a' && c <= 'z' ) {
        return 0x90 + c - 'a';
    }
    if ( c >= '0' && c <= '9' ) {
        return 0x70 + c - '0';
    }
    for ( i = 0; Alpha[ i ].c != '\0'; ++i ) {
        if ( Alpha[ i ].c == c ) {
            return Alpha[ i ].code;
        }
    }
    return 0;
}


/*
 *  Store the file name in the header bytes 2..7
 *
 *  The name is right aligned and padded with 0x0F. Bit 7 of the
 *  characters is not stored, the nibbles are spread over the header
 *  bytes as described in list602.c.
 */
bool setName( unsigned char *h, const char *name )
{
    int c[ NAME_LEN ];
    int len = (int) strlen( name );
    int i;

    if ( len > NAME_LEN ) {
        fprintf( stderr, "File name \"%s\" too long\n", name );
        return false;
    }
    for ( i = 0; i < NAME_LEN; ++i ) {
        if ( i < NAME_LEN - len ) {
            c[ i ] = NAME_PADDING;
        }
        else if ( ( c[ i ] = alphaCode( name[ i - NAME_LEN + len ] ) ) == 0 ) {
            fprintf( stderr, "Invalid character '%c' in file name\n",
                     name[ i - NAME_LEN + len ] );
            return false;
        }
        c[ i ] &= 0x7F;
    }
    h[ 2 ] = (unsigned char) ( ( c[ 4 ] & 0x0F ) << 4 | ( c[ 5 ] & 0x0F ) );
    h[ 3 ] = (unsigned char) ( ( c[ 2 ] & 0x0F ) << 4 | ( c[ 3 ] & 0x0F ) );
    h[ 4 ] = (unsigned char) ( ( c[ 0 ] & 0x0F ) << 4 | ( c[ 1 ] & 0x0F ) );
    h[ 5 ] = (unsigned char) ( ( c[ 4 ] & 0xF0 ) | c[ 5 ] >> 4 );
    h[ 6 ] = (unsigned char) ( ( c[ 2 ] & 0xF0 ) | c[ 3 ] >> 4 );
    h[ 7 ] = (unsigned char) ( ( c[ 0 ] & 0xF0 ) | c[ 1 ] >> 4 );
    return true;
}


/*
 *  Check for the 2 header bytes of an FX-501P/FX-502P file:
 *  second and third digit of the file number, type and first digit
 */
bool isHeader502( const unsigned char *h )
{
    int type = h[ 1 ] >> 4;

    return ( type == TYPE502_PROGRAM || type == TYPE502_DATA )
        && ( h[ 1 ] & 0x0F ) <= 9
        && ( h[ 0 ] >> 4 ) <= 9 && ( h[ 0 ] & 0x0F ) <= 9;
}


/*
 *  Check for the 8 header bytes of an FX-601P/FX-602P file
 */
bool isHeader602( const unsigned char *h )
{
    return h[ 1 ] == TYPE602_PROGRAM || h[ 1 ] == TYPE602_ALL
        || h[ 1 ] == TYPE602_DATA;
}


/*
 *  Store the file number in the header
 *
 *  FX-601P/FX-602P: header bytes 2..7 = last digit and 0xA,
 *                   first and second digit, 0xFF 0xFF 0xFF 0xFF
 *  FX-501P/FX-502P: header bytes 0..1 = second and third digit,
 *                   type and first digit
 */
void setNumber( unsigned char *h, int number, bool fx502 )
{
    int d1 = number / 100, d2 = number / 10 % 10, d3 = number % 10;

    if ( fx502 ) {
        h[ 0 ] = (unsigned char) ( d2 << 4 | d3 );
        h[ 1 ] = (unsigned char) ( ( h[ 1 ] & 0xF0 ) | d1 );
    }
    else {
        h[ 2 ] = (unsigned char) ( d3 << 4 | 0x0A );
        h[ 3 ] = (unsigned char) ( d1 << 4 | d2 );
        memset( h + 4, 0xFF, 4 );
    }
}


/*
 *  Main entry point
 */
int main( int argc, char **argv )
{
    long skip = 0;
    int lead_in = LEAD_IN_TIME;
    char *name = NULL;
    char *number = NULL;
    bool fx502;
    FILE *infp;
    KCS_FILE *out;
    int c, count = 0, i;

    while ( argc > 1 && argv[ 1 ][ 0 ] == '-' ) {

        if ( strncmp( argv[ 1 ], "-b", 2 ) == 0 ) {
            skip = atol( argv[ 1 ] + 2 );
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
        printf( "usage: wave602 <options> infile outfile\n"
                "         -b<skip> reads a binary file, "
                           "<skip> is an optional offset\n"
                "         -n<name> sets the file name (up to 6 characters, "
                           "FX-601P/FX-602P only)\n"
                "         -f<number> sets the file number (0..999, "
                           "0 for none)\n"
                "         -l<time> length of the lead-in in tens of "
                           "a second (default %d)\n",
                LEAD_IN_TIME );
        return 2;
    }

    if ( ( infp = fopen( argv[ 1 ], "rb" ) ) == NULL ) {
        fprintf( stderr, "\nCannot open the file %s\n", argv[ 1 ] );
        perror( "error" );
        return 2;
    }
    while ( ( c = fgetc( infp ) ) != EOF && count < MAX_BYTES ) {
        if ( skip > 0 ) {
            --skip;
            continue;
        }
        Data[ count++ ] = (unsigned char) c;
    }
    fclose( infp );

    if ( count <= HEADER_LEN ) {
        fprintf( stderr, "File %s is too short\n", argv[ 1 ] );
        return 2;
    }
    fx502 = isHeader502( Data );
    if ( !fx502 && !isHeader602( Data ) && ( name != NULL || number != NULL ) ) {
        fprintf( stderr, "Unknown file format, cannot set the name or number\n" );
        return 2;
    }
    if ( name != NULL && number != NULL ) {
        fprintf( stderr, "Either a name or a number can be set\n" );
        return 2;
    }
    if ( name != NULL && fx502 ) {
        fprintf( stderr, "Files of the FX-501P/FX-502P have no name, "
                         "use -f to set the number\n" );
        return 2;
    }
    if ( name != NULL && !setName( Data, name ) ) {
        return 2;
    }
    if ( number != NULL ) {
        char *end;
        long n = strtol( number, &end, 10 );

        if ( *number == '\0' || *end != '\0' || n < 0 || n > 999 ) {
            fprintf( stderr, "Invalid file number \"%s\"\n", number );
            return 2;
        }
        setNumber( Data, (int) n, fx502 );
    }

    if ( ( out = kcsOpen( argv[ 2 ], "wb", 300, 8, 'E', 2 ) ) == NULL ) {
        fprintf( stderr, "\nCannot create the file %s\n", argv[ 2 ] );
        perror( "error" );
        return 2;
    }
    if ( 0 != kcsLeadIn( out, lead_in ) ) {
        perror( "write" );
        return 2;
    }
    for ( i = 0; i < count; ++i ) {
        if ( 0 != kcsWriteByte( out, Data[ i ] ) ) {
            perror( "write" );
            return 2;
        }
    }
    /*
     *  Short leader for termination
     */
    kcsLeadIn( out, 1 );
    kcsClose( out );

    return 0;
}
