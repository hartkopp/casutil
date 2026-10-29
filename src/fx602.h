/*
 *  fx602.h - Codes of the Casio FX-501P/FX-502P and FX-601P/FX-602P
 *
 *  Tables and definitions shared by list602.c and prg602.c, which must
 *  use the same names to translate programs in both directions.
 *  The header is included by a single source file of each program.
 */

#define HEADER_LEN 8
#define NAME_LEN   6          /* characters of a file name */
#define NAME_PADDING 0x0F     /* fills short names from the left */
#define FOOTER_LEN 8          /* number of 0xFF bytes */
#define REG_LEN    8          /* bytes per data register */

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

#define TYPE502_PROGRAM 0xB   /* FX-502P file types, high nibble of byte 1 */
#define TYPE502_DATA    0xF
#define HEADER502_LEN   2
#define REGISTERS502    22

#define TOKEN_ALPHA     0x2B  /* starts and ends alpha mode */
#define TOKEN_M20       0x2C  /* prefix for M20..M39 and FIX */
#define TOKEN_M80       0x2F  /* prefix for M80..M99 (synthetic) */
#define TOKEN_PASSWORD  0xEC  /* terminates the password */

/*
 *  Names in ASCII and UTF-8
 */
typedef struct _name {
    const char *ascii;
    const char *utf8;
} NAME;

/*
 *  Standard plane
 *  The memory operations 0x50..0xE9 (columns 0..9) and 0xF0..0xF9
 *  are handled by memoryName() and are left out here.
 *  Names in parentheses are synthetic codes, which are displayed like the
 *  command named, but act differently (E. Welker, Sedezimal-Code, 1982):
 *  (SAC) like xD, (SAC:) like xDEL, (GRA) like ISZ, (10^x) halts like BST,
 *  (e^x) halts on a key pressed, SA executes the next step and halts.
 *  NULL marks unknown codes and 0xEA, 0xEB, which both display "Error".
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
    [ 0x3B ] = { "(SAC)" },
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
    [ 0x6A ] = { "(GRA)" },
    [ 0x6F ] = { "PI", "\xCF\x80" },
    [ 0x7A ] = { "ISZ" },      [ 0x7B ] = { "x>=0", "x\xE2\x89\xA5" "0" },
    [ 0x7C ] = { "x>=F", "x\xE2\x89\xA5" "F" },
    [ 0x7D ] = { "xbar", "x\xCC\x84" },
    [ 0x7E ] = { "sdn", "\xCF\x83n" },
    [ 0x7F ] = { "sdn-1", "\xCF\x83n-1" },
    [ 0x8A ] = { "PAUSE" },    [ 0x8B ] = { "IND" },
    [ 0x8C ] = { "SAVE" },     [ 0x8D ] = { "LOAD" },
    [ 0x8E ] = { "MAC" },      [ 0x8F ] = { "SAC" },
    [ 0x9A ] = { "xDEL" },    [ 0x9B ] = { "(SAC:)" },
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
    /* INV MODE on the FX-501P/FX-502P, ALPHA (0x2B) on the FX-601P/FX-602P */
    [ 0xFB ] = { "NOP" },
    [ 0xFC ] = { "(10^x)", "(10\xCB\xA3)" },
    [ 0xFD ] = { "(e^x)", "(e\xCB\xA3)" },
    [ 0xFE ] = { "SA" },      /* synthetic, a programmed FST */
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
    [ 0x55 ] = { "<" }, [ 0x56 ] = { ">" },
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
 *  Store a file number in the header bytes 2..7 of an FX-601P/FX-602P
 *  file: last digit and 0xA, first and second digit, 0xFF 0xFF 0xFF 0xFF
 *  The number 000 means no name.
 */
void encodeNumber602( int *h, int number )
{
    h[ 2 ] = number % 10 << 4 | 0x0A;
    h[ 3 ] = number / 100 << 4 | number / 10 % 10;
    h[ 4 ] = h[ 5 ] = h[ 6 ] = h[ 7 ] = 0xFF;
}


/*
 *  Store a file name of len alpha codes in the header bytes 2..7 of an
 *  FX-601P/FX-602P file: right aligned, padded with 0x0F, the nibbles of
 *  the characters spread over the bytes. Bit 7 is not stored for lower
 *  case letters and the codes 0xAA..0xAF, which appear as 0x10..0x2F.
 */
void encodeName602( int *h, const int *codes, int len )
{
    int c[ NAME_LEN ];
    int i;

    for ( i = 0; i < NAME_LEN; ++i ) {
        c[ i ] = i < NAME_LEN - len ? NAME_PADDING : codes[ i - NAME_LEN + len ];
        if ( c[ i ] >= 0x90 && c[ i ] <= 0xAF ) {
            c[ i ] &= 0x7F;
        }
    }
    h[ 2 ] = ( c[ 4 ] & 0x0F ) << 4 | ( c[ 5 ] & 0x0F );
    h[ 3 ] = ( c[ 2 ] & 0x0F ) << 4 | ( c[ 3 ] & 0x0F );
    h[ 4 ] = ( c[ 0 ] & 0x0F ) << 4 | ( c[ 1 ] & 0x0F );
    h[ 5 ] = ( c[ 4 ] & 0xF0 ) | c[ 5 ] >> 4;
    h[ 6 ] = ( c[ 2 ] & 0xF0 ) | c[ 3 ] >> 4;
    h[ 7 ] = ( c[ 0 ] & 0xF0 ) | c[ 1 ] >> 4;
}
