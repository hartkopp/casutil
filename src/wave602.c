/*
 *  wave602.c - Create Casio FX-601P/FX-602P tape WAV files
 *
 *  This program creates a WAV file from a tape image of the FX-601P or
 *  FX-602P calculator, which can be loaded through the FA-1 or FA-2
 *  cassette interface. The binary file contains the 8 header bytes,
 *  the programs or registers and the footer, e.g. as created by
 *  "wav2raw -b" or by the FX-602P simulator by Martin Krischik.
 *
 *  Options:
 *    -b<skip>   read BIN file (Default); skip <skip> garbage bytes
 *    -n<name>   set the file name in the header (up to 6 characters)
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
 *  Main entry point
 */
int main( int argc, char **argv )
{
    long skip = 0;
    int lead_in = LEAD_IN_TIME;
    char *name = NULL;
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
                "         -n<name> sets the file name (up to 6 characters)\n"
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
    if ( name != NULL && !setName( Data, name ) ) {
        return 2;
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
