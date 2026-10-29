# CASsette IO Utilities

Utilities to handle tape recordings and floppy disk images of vintage pocket
computers: mainly Casio BASIC pocket computers and graphics calculators, as
well as the Canon X-07 and the Texas Instruments TI-74.

The utilities were written by Marcus von Cube and are licensed under the GNU
General Public License, version 2 (see [COPYING](COPYING)). This repository
maintains the Linux version.

The complete original documentation is available online at
<https://www.mvcsys.de/doc/casioutil.html>; a local copy is
[doc/casioutil.html](doc/casioutil.html). This README summarizes the parts
that apply to this repository. The sections about DOS, Windows, OS/2 and
Windows CE do not apply anymore.


## Programs

| Program  | Purpose |
|----------|---------|
| list702  | List a binary or WAV file as BASIC text (FX-702P) |
| list730  | List a binary or WAV file as BASIC text (PB-100 series, FX-730P) |
| list850  | List a binary or WAV file as BASIC text or data (PB-700 and later: FX-850P, PB-1000, FP-200) |
| list8000 | List programs, registers, graphics and text of the fx-8000G graphics calculators, export to FA-121 (CAS) and FA-122..124 (CAT) |
| listX07  | List a binary or WAV file as BASIC text (Canon X-07) |
| list74   | List a binary, PGM or WAV file as BASIC text (TI-74) |
| list602  | List programs and data registers of a binary or WAV file (FX-601P, FX-602P, FX-501P, FX-502P) |
| wave730  | Create a WAV file from a binary file (PB-100 series, also FX-702P) |
| wave850  | Create a WAV file from a binary file (PB-700 and later, FP-200) |
| waveX07  | Create a WAV file from a binary file (Canon X-07) |
| wave602  | Create a WAV file from a binary file (FX-601P, FX-602P, FX-501P, FX-502P) |
| prg602   | Create a WAV or binary file from a listing of programs or data (FX-601P, FX-602P, FX-501P, FX-502P) |
| bas702   | Create a WAV, binary or ASCII encoded file from BASIC source (FX-702P) |
| bas730   | Create a WAV, binary or ASCII encoded file from BASIC source (PB-100 series) |
| bas850   | Create a WAV, binary, ASCII encoded or plain text file from BASIC source (PB-700 and later, FP-200) |
| basX07   | Create a WAV, binary or plain text file from BASIC source (Canon X-07) |
| wav2raw  | Extract a binary image from a WAV file (all models) |
| wav2wav  | Recreate a WAV file bit for bit, optionally at a different speed |
| md100    | Handle disk images of the MD-100 floppy drive (PB-1000, PB-2000C) |

Each program prints its options when it is called without arguments.


## Building and installing

```
make
make clean
sudo make install
```

`make` builds the tape utilities in `src` and `md100` in the `md100`
directory. `sudo make install` copies all programs and the MD-100 shell
scripts to `/usr/local/bin`. `make clean` removes the object files,
`make distclean` the programs as well.

| Directory | Contents |
|-----------|----------|
| `src`     | source code of the tape utilities, the programs are built here |
| `md100`   | source code of md100, shell scripts and documentation for the MD-100 floppy drive |
| `doc`     | original documentation, BASIC comparison sheet and character set tables |
| `pb-dump` | memory dump example for the PB-770 |


## Supported machines

The Casio BASIC pocket computers fall into groups. Within a group, programs
can be exchanged through the tape interface, although not every keyword is
available on every machine. Details about the BASIC dialects are in the
BASIC comparison sheet ([doc/basic-compare.html](doc/basic-compare.html)).

- **PB-100 series** (PB-100, PB-110, PB-220, PB-240, PB-300, PB-410,
  FX-700P, FX-720P, FX-730P, FX-770P, FX-785P, FX-790P, FX-795P):
  special internal character encoding, 300 bit/s through the FA-3.
  Tools: `list730`, `wave730`, `bas730`.
- **FX-702P**: its own BASIC dialect (`PRT`, `INP`, `GSB`, `RET`) and
  character encoding, 300 bit/s through the FA-2.
  Tools: `list702`, `bas702`; `wave730` can create its WAV files.
- **PB-700, PB-770, FX-750P**: ASCII with graphics characters, 300 bit/s
  through the FA-10 or FA-20. The FX-750P does not support lowercase
  characters. Tools: `list850`, `wave850`, `bas850`.
- **FX-850P, FX-870P, FX-880P, FX-890P, VX-1 to VX-4, Z-1, PB-1000**:
  "JIS Standard BASIC" with tokenized keywords. FA-6 interface with
  1200 bit/s; the PB-1000 uses the FA-7 with up to 2400 bit/s. The Z-1 and
  FX-890P have no tape interface but can be used with `bas850` and a serial
  or USB interface. Tools: `list850`, `wave850`, `bas850`.
- **FP-200**: 300 bit/s, a different binary encoding than the FX-850P.
  Use option `-2` with `list850`, `wave850` and `bas850`.
- **FX-601P, FX-602P**: keystroke programmable calculators, 300 bit/s
  through the FA-1 or FA-2. Programs are stored as one byte per step.
  Files can have a file number (100..999) instead of a name. The FX-601P
  has 128 steps like the FX-602P with `MODE . 68`, but saves only 16
  registers: M00..M09, MF and its 5 registers for parentheses.
  Tools: `list602`, `wave602`, `prg602`.
- **FX-501P, FX-502P**: same interface and program codes as the FX-602P,
  but a 2 byte header with type and file number, the whole program area
  (128 or 256 steps) or the data registers (16 or 22, the FX-501P saves
  its 5 registers for parentheses as well). The FX-602P loads these
  files. Tools: `list602`, `wave602`, `prg602`.
- **MD-100 floppy drive** with the PB-1000 and the PB-2000C: `md100`.
- **Casio fx-8000G** graphics calculator with the FA-80 interface, 2400
  bit/s: `list8000`.
- **Canon X-07**: 1200 bit/s, 8 data bits, no parity, 2 stop bits:
  `listX07`, `waveX07`, `basX07`.
- **TI-74** with the CI-7 cassette interface: a special synchronous format
  with 1400 bit/s: `list74`.

The PB machines (PB-700 series, PB-1000, FP-200) use `LGT` for the base 10
logarithm and `LOG` for the natural logarithm, all other machines use `LOG`
and `LN`. The `-l` options of the list and bas utilities convert between both.

### FX-501P/FX-502P and FX-601P/FX-602P

The calculators share the program codes, as a test program typed on an
FX-502P shows. The FX-602P has a two-digit register address, so M.0..M.9
and M.F of the FX-502P are M10..M19 and M1F there; `list602` shows the
names of the FX-502P in its programs. INV MODE is ALPHA (0x2B) on the
FX-601P/FX-602P and NOP (0xFB) on the FX-501P/FX-502P. The FX-501P/FX-502P
have no alpha text, password and FIX, which use the codes 0x2B..0x2F and
0xEC, `prg602` warns about them. The FX-602P manual (page 65) lists which
calculator loads the files of which:

| Saved by | Loaded by | Condition |
|----------|-----------|-----------|
| FX-501P | FX-501P, FX-502P, FX-601P | none |
| FX-501P | FX-602P | program area of at least 128 steps |
| FX-502P | FX-502P | none |
| FX-502P | FX-501P | programs up to 128 steps, data up to 11 registers |
| FX-502P | FX-601P | programs up to 128 steps, data up to 11 registers, else "OP Error" |
| FX-502P | FX-602P | 256 steps and at least 20 registers assigned |
| FX-601P | FX-601P | none |
| FX-601P | FX-602P | `MODE . 68`: M00..M67 and 128 steps |
| FX-602P | FX-602P | the memory partition used for saving |
| FX-602P | FX-601P | programs up to 128 steps, data up to 11 registers, else "OP Error"; programs and data saved with `MODE . 68`, ending with "OP Error" |

No other path is possible, an FX-601P/FX-602P file cannot be loaded into
an FX-501P/FX-502P. `prg602` creates the files for any of these
calculators from a listing (`# @calculator`).


## Handling tape recordings

### Recording

Connect the microphone cable of the tape interface to the sound card and
record:

- WAV format, 8 bits per sample (no floating point format)
- 11025 or 22050 samples per second; 44100 is recommended for 2400 bit/s
- mono
- a recording level that fills the dynamic range (or amplify the
  recording later with a sound editor like Audacity)

Start the recording, send the program or data from the pocket computer
(`SAVE`, `SAVE ALL`, `PUT`, `WRITE#`) and stop when the prompt returns.

Fast recordings (1200 bit/s and more) are harder to decode. In case of
problems set the environment variable `WAVE_PHASE=1` (or append `-` to the
speed option, e.g. `-f-`) or invert the recording in a sound editor. For
very quiet recordings try `WAVE_THRESHOLD` with values above 10, or better
normalize the recording.

### Playing

Connect the EAR input of the tape interface to the headphone output of the
sound card.

**Caution:** The mono cable of the tape interface shorts one channel of the
stereo output and may damage the sound card. Use an adapter that connects
just one channel.

Enter the `LOAD`, `LOAD ALL`, `READ#` or `GET` command on the pocket
computer, then play the WAV file with a high output level. When a program
reads data in chunks and uses the REMote plug to stop the tape, pause and
resume the playback by hand.

### Refreshing recordings

`wav2wav` recreates a recording in the Kansas City Standard bit for bit as a
clean wave. The result is compressed much better by ZIP or GZIP and avoids
problems with recordings that end badly. It converts between 300, 1200 and
2400 bit/s, e.g. `-oh` for a PB-700 file to be loaded into a PB-1000, or
`-ih -of` for a PB-1000 recording to be loaded into an FX-850P. Special
modes are 500 bit/s for Sharp pocket computers (`-5`) and 1400 bit/s for the
TI-74/95 (`-t`).

### Converting to binary formats

`wav2raw` decodes a WAV file into one of these formats:

- `-b` bytes: just the decoded data, the basis for the list programs
- `-w` words: lead-in sequences, framing and parity information preserved
- `-r` raw: the 12 bits per byte (start, stop and parity bits) as 16 bit
  words
- `-a` ASCII encoded raw data as used by Piotr Piatek's serial interface

Use `-f -pN2` for the Canon X-07 and `-h-` for the fx-8000G with the FA-80.

### Listing as text

The list programs read a WAV file (`-w`), a binary file (`-b`) or an ASCII
encoded file from Piotr's interface (`-a`) and write the listing to
standard output.

- `list850`: for a PB-1000 program use `-eP` (or `-uP` for UTF-8) and `-lP`;
  `-2` handles the FP-200; `-d` reads a file copied from an MD-100 disk;
  `-n` suppresses the header for data files.
- `list730` and `list702`: use `-e` to create escape sequences that `bas730`
  or `bas702` can translate back.
- `listX07` and `list74`: `-e` creates escape sequences, `-c` translates the
  character set (code page 437 or 1252).
- `list8000`: lists all record types of the fx-8000G, writes graphics as BMP
  files (`-g`) and exports CAS files for FA-121 (`-cas`) or CAT files for
  FA-122..124 (`-cat`).
- `list74`: `-r` writes a PGM file for the TI PC interface.
- `list602`: lists program, data, "all" and display data files of the FX-601P/FX-602P
  with file name or number, password, memory partition (`MODE .`),
  program steps and the memory registers. Program and data files of the
  FX-501P/FX-502P are listed as well, with the data registers M0..M9, MF
  and on the FX-502P M.0..M.9, M.F. Binary files are also accepted in the format of the
  FX-602P simulator by Martin Krischik. `-u` shows symbols like `↔`, `π`
  and `√` in UTF-8, `-s` adds the step numbers as shown by the calculator
  in WRT mode, `-x` the hex codes of all steps and the step numbers. Codes
  without known meaning, e.g. from synthetic programming, are shown as `[XX]`,
  unknown alpha characters as `\XX`. Each file starts with the comment
  lines `# @calculator`, `# @file`, `# @name` or `# @number` and
  `# @mode`, which describe the file for `prg602`, and `# @rawheader` if
  these lines do not describe the header exactly. Numbers, which would not
  be written back into the same bytes, e.g. not normalized ones, are
  followed by their bytes as with `-x`, so a listing reproduces the file.

Example for an fx-8000G recording:

```
list8000 -catMYAPP-#.FX -p3 -w myapp.wav > myapp.cat
list8000 -casA -p3 -w myapp.wav MYAPP.CAS
```

### Creating WAV files

`wave730`, `wave850` and `waveX07` create a WAV file from a binary file. The
lead-in sequences are shorter than in an original recording, which saves
time when loading. `wave850` creates slow (`-s`) or fast (`-f`) files; use
`-2` for the FP-200, which needs longer lead-ins.

`wave602` creates a WAV file for the FX-601P/FX-602P or FX-501P/FX-502P
from a binary file with header, programs or registers and footer, e.g. from
`wav2raw -b`. The format is detected from the header. `-n<name>` sets the
file name (FX-601P/FX-602P only), `-f<number>` the file number (0 for
none), which helps to repair a recording with a damaged header.

See [doc/fx602.md](doc/fx602.md) for recipes, an example and the tables
of all program codes.

`prg602` translates a listing in the format of `list602` back into a WAV
file (`-b`: binary file), so programs and data can be listed, edited and
loaded into the calculator again. The text describes the file completely,
the extension `.prg` is used for these listings like `.bas` for BASIC
programs:

- Comment lines `# @key value` describe the file, `list602` writes them in
  front of each file. Options of `prg602` take precedence:

  | Line | Values | Default | Option |
  |------|--------|---------|--------|
  | `# @calculator` | `602`, `601`, `502`, `501` | `602` | `-c<calc>` |
  | `# @file` | `program`, `data`, `all`, `display` | from the content | |
  | `# @name` | `"name"`, up to 6 characters (FX-601P/FX-602P) | no name | `-n<name>` |
  | `# @number` | `0`..`999` | no name | `-f<number>` |
  | `# @mode` | memory partition `.20`..`.80` (FX-602P) | `.20` | |
  | `# @rawheader` | all bytes of the header in hex | | |

  `601` is the FX-601P with 128 steps and 16 registers, `502` and `501`
  write the program area of 256 or 128 steps. `# @rawheader` replaces the
  header created from the other lines, which still describe the contents,
  `-n` and `-f` take precedence. An unknown key is an error.
- `*** P0`..`*** P9` start a program, as in the listings of the printer
  FP-10. `list602` writes one step per line and the number of steps behind
  each program as comment, e.g. `# 170 steps`, which includes the program
  marker as with the FP-10. `prg602` also accepts several steps in a line
  separated by blanks. Step numbers of 3 digits at the beginning of a line
  (`list602 -s`), which are only for information, and the hex codes of
  `list602 -x` are ignored.
- Steps are written as listed by `list602`, in ASCII or UTF-8, e.g.
  `MR1F`, `FIX2`, `x^2` or `x²`, the registers also as on the
  FX-501P/FX-502P, e.g. `MR5`, `MR.5` or `M+.F`. Names of steps are also
  accepted in other case.
- Alpha text is written in quotes with the escapes of `list602`, e.g.
  `"r=\AR05"` (INV AR 0 5 on the keyboard), the registers
  for parentheses as `\ARL2`..`\ARL11` (synthetic), codes without name as
  `[XX]`, a password of 4 characters as `Password "AB12"` behind the
  program marker. A program ending in alpha mode without the closing
  0x2B is listed with `\FF` instead of the closing quote, e.g. `"OFFEN\FF`.
- Data registers are written as `M05 = 1.5`, `M1F = -2.5e-12`, on the
  FX-501P/FX-502P also as `M5`, `M.5`, `M.F`, the L registers of the
  FX-501P/FX-601P as `[11]`..`[15]`. A value is a number, 8 bytes in
  brackets or a number followed by the bytes in brackets, which take
  precedence. Hex digits are only accepted in numbers marked as
  `(synthetic)`. Registers which are not listed are 0.
- Display data are written as `Display = 55555` or `Display = "TEXT"`,
  optionally followed by the bytes or the 16 codes in brackets. The FX-602P loads
  such files, but shows 0 afterwards, also for its own recordings, so they
  are probably only useful for printing from the tape (FA-2 in PRT/MT).
- `#` starts a comment at the beginning of a line or behind a step,
  e.g. `LBL0  # main loop`, also behind `RAN#` or `"123 #"`. Empty lines
  and the headings `***` of `list602` are ignored.

```
list602 -w statpc.wav > statpc.prg
prg602 statpc.prg statpc2.wav
```

The BASIC translators `bas702`, `bas730`, `bas850` and `basX07` read a
source file, which may come from a list utility or an editor, and create a
WAV, binary or ASCII encoded file:

- Keywords may be written in lower or mixed case. Everything outside
  strings, comments and DATA lines is converted to uppercase (`bas850 -l`
  keeps lowercase for machines with case sensitive variable names).
- `'` may be used instead of `REM`; it is translated for the older machines.
- Lines without a line number are ignored and can be used for comments.
- The translators bridge dialect differences where possible, e.g. `PRINT`
  to `PRT` for the FX-702P (`bas702`), or old and new style keywords with
  `bas730 -o`/`-n` and `bas850 -o`.
- Special characters are entered as backslash escape sequences like `\PI`
  or as two hexadecimal digits like `\3B`. `bas850 -uF`/`-uP` and
  `basX07 -cU` accept UTF-8 input. The character sets are documented in
  [doc/Casio_FX-850P_Charset.pdf](doc/Casio_FX-850P_Charset.pdf),
  [doc/Casio_PB_700_Charset.pdf](doc/Casio_PB_700_Charset.pdf) and
  [doc/Canon_X-07_Token.pdf](doc/Canon_X-07_Token.pdf).

Notes on `bas850`:

- `-tT` creates plain text that can be sent to a serial or USB interface.
  Without an output file it writes to standard output, e.g. for piping into
  `md100`.
- `-tA` creates `SAVE,A` files, slow because of a lead-in before each line;
  `-tB` is a blocked variant for the FP-200 and FX-850P.
- `-t7` creates the internal format for the PB-700 family, `-t8` for the
  FX-850P and PB-1000. For the PB-1000 add `-lF`, because the token table
  only knows the `LOG`/`LN` syntax.
- `-d` creates data files; the delay parameter replaces the REMote control
  of the tape.

### Serial interface

`bas850 -tT` and `basX07 -t` create plain text for the serial interface.
The original documentation shows the Windows commands. The parameters are
4800 bit/s, 8 data bits, even parity, 2 stop bits and XON/XOFF for the
FX-850P (`LOAD"COM0:6"`), and 2400 bit/s, 8 data bits, no parity, 2 stop
bits and RTS/CTS handshake for the Canon X-07, which has to run a small
remote control program first:

```
10 INIT#5,"COM:",2400
20 EXEC &HEE1F
```


## MD-100 floppy disk images

The MD-100 is the floppy drive of the PB-1000 and the PB-2000C. `md100`
works on disk images, files that contain all sectors of a disk. How to read
and write real disks under Linux, the hardware requirements and the disk
format are described in [md100/md100.txt](md100/md100.txt).

```
md100 [-c[S]] [-n] <image> <cmd> <options> <parameters>
```

Commands: `dir`, `type`, `get`, `mget`, `put`, `mput`, `del`, `ren`, `set`.
Option `-c` creates a new image, option `-n` prevents any update of the
image. Instead of an image, md100 can also work directly on the floppy
device `/dev/fd0casio`; this is much slower than working on an image.

- File names have up to 8 characters plus a 3 character extension. Case is
  preserved and there are no subdirectories.
- Patterns for files on the disk must be enclosed in double quotes, e.g.
  `md100 md100.img dir -i "*.bas" "*.c"`.
- File types: `S` sequential (ASCII text with CR+LF, MEMO files, `SAVE,A`),
  `R` relative or random data files, `M` machine code, `B` tokenized BASIC,
  `C` C source or BAT files. When copying files to the disk, md100 guesses
  the type from the extension: `.c`, `.h` and `.BAT` are type C, `.BAS`
  type B, `.REL` type R, all others type S. Override it with `-t`.
- Bit 0 of the attribute byte protects a file (option `-p`).
- Files are stored in blocks of 1 KB and end with the EOF marker 0x1A.
- ASCII mode is the default for all types except M, R and B. Copy files
  that were saved in binary mode back with `-b`, PC text files with `-a`.
  `-e` handles escape sequences like `bas850`.

Examples:

```
md100 md100.img                                 # list the directory
md100 md100.img type PI.BAS                     # list a BASIC program
md100 md100.img get -i pi.bas md100-dat/*       # copy a file to the PC
md100 md100.img mget -tB -d md100-dat/ "*"      # copy all BASIC files
md100 md100.img put -u -e pi.asc                # copy a text file to the disk
md100 md100.img mput -l -d "*.txt" *.asc        # copy and rename files
bas850 -lP -tT fx-850.txt | md100 md100.img put stdin "fx-850.txt"
md100 md100.img ren -tB -l "*" "*.bas"          # rename all BASIC files
md100 md100.img del "hoch*.c"                   # delete files
md100 md100.img set -tC "*" -tS -p1             # change type and protection
```

The PB-1000 misinterprets files of type C as type R. Change them to type S
with `set` to access files created by the PB-2000C.


## Example: dumping the memory of a PB-770

The directory [pb-dump](pb-dump) contains `undump.c` and the archive
`pb-dump.zip` with a BASIC program that writes the RAM of a PB-770 to tape
as hexadecimal text. `undump.c` converts the listing created by
`list850 -w` into a binary file. The procedure is described in the original
documentation.


## Documentation

- [doc/casioutil.html](doc/casioutil.html): the original documentation
- [doc/basic-compare.html](doc/basic-compare.html): comparison of the BASIC
  dialects of Casio, Sharp, HP, TI, Canon and Epson pocket computers
- [md100/md100.txt](md100/md100.txt): MD-100 floppy disks under Linux
- [doc/fx602.md](doc/fx602.md): FX-601P/FX-602P and FX-501P/FX-502P: files,
  recipes, the listing format and the tables of all program codes
- character set and token tables for the FX-850P, PB-700 and Canon X-07 in
  [doc](doc)


## Links

- Original documentation: <https://www.mvcsys.de/doc/casioutil.html>
- Piotr Piatek, who inspired much of this work and documented the Casio
  hardware, interfaces and the MD-100: <https://www.pisi.com.pl/piotr433/>
- Synthetic programming of the FX-602P with the table of all codes:
  E. Welker, Sedezimal-Code (1982),
  <https://vpc.w10.site/fx602p/Casio%20FX602P%20Sedimalcode%201.pdf>
- FX-602P and FX-603P token codes, file format and simulator by Martin
  Krischik: <https://fx-602p.krischik.com>, manuals of the FX-602P,
  FX-502P, FA-1 and FA-2: <https://fx-602p.krischik.com/fx-602p/manuals/>
- Ledudu's site about Casio calculators and pocket computers:
  <http://www.ledudu.com/pockets.asp>
- rskey.org about programmable calculators: <http://www.rskey.org>
- Scanned Casio manuals at SilRun Systems: <http://www.silrun.de/>
- Casio file format documentation project:
  <http://casetta.tuxfamily.org/formats>

These links are taken from the original documentation of 2015. More links,
some of them no longer reachable, are listed there.
