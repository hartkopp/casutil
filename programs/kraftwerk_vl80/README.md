# Kraftwerk on the Casio VL-80, converted for the FA-1/FA-2

In 1981 Kraftwerk issued the Casio VL-80 melody calculator with a score of
eleven of their songs, written as the keys of the VL-80. The band played its
music on a Casio FX-501P with the FA-1, so the scores are converted here into
music programs for the FA-1/FA-2: `fx602` for the FX-601P/FX-602P ("all"
files with program and note data), `fx502` for the FX-501P/FX-502P (program
`KWnn` and data `KWnnD` with the same file number, as these calculators save
programs and registers separately).

## Keys of the VL-80

The keys play G3..A5 (operation manual of the VL-80, Manual Play Function),
the semitone key (shown as `#` in the score) together with a key plays the
semitone above:

| Key | = | . | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | ÷ | × | - | + |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Note | G3 | A3 | B3 | C4 | D4 | E4 | F4 | G4 | A4 | B4 | C5 | D5 | E5 | F5 | G5 | A5 |

The FA-1/FA-2 note codes of these notes are in the table of the FA-2 manual,
`list602 -m` shows the notes of a file.

## Conversion

The score gives only the keys and no note lengths, the VL-80 plays the stored
notes in the rhythm of its key (One Key Play). Each note is an eighth note
(`Min`), each blank between the groups of the score an eighth rest (`MinF`),
and the program ends with `AC`. The comment behind a line gives the keys of
the score. Each song uses one register per note, the tempo code in MF is 2
(120 quarter notes per minute) on the FX-601P/FX-602P and 3 (112) on the
FX-501P/FX-502P. Change single `Min` to `MR` (quarter) or `X<->M` (16th) to
play the rhythm of the record.

| No. | Title | FX-601P/FX-602P | FX-501P/FX-502P | File number | Steps |
|---|---|---|---|---|---|
| 01 | Der Taschenrechner | [KW01](fx602/KW01.prg) | [KW01](fx502/KW01.prg), [KW01D](fx502/KW01D.prg) | 701 | 75 |
| 02 | Computerwelt | [KW02](fx602/KW02.prg) | [KW02](fx502/KW02.prg), [KW02D](fx502/KW02D.prg) | 702 | 59 |
| 03 | Radioaktivität | [KW03](fx602/KW03.prg) | [KW03](fx502/KW03.prg), [KW03D](fx502/KW03D.prg) | 703 | 61 |
| 04 | Neonlicht | [KW04](fx602/KW04.prg) | [KW04](fx502/KW04.prg), [KW04D](fx502/KW04D.prg) | 704 | 65 |
| 05 | Autobahn | [KW05](fx602/KW05.prg) | [KW05](fx502/KW05.prg), [KW05D](fx502/KW05D.prg) | 705 | 53 |
| 06 | Computerliebe | [KW06](fx602/KW06.prg) | [KW06](fx502/KW06.prg), [KW06D](fx502/KW06D.prg) | 706 | 49 |
| 07 | Die Roboter | [KW07](fx602/KW07.prg) | [KW07](fx502/KW07.prg), [KW07D](fx502/KW07D.prg) | 707 | 41 |
| 08 | Das Model | [KW08](fx602/KW08.prg) | [KW08](fx502/KW08.prg), [KW08D](fx502/KW08D.prg) | 708 | 80 |
| 09 | Metropolis | [KW09](fx602/KW09.prg) | [KW09](fx502/KW09.prg), [KW09D](fx502/KW09D.prg) | 709 | 35 |
| 10 | Trans Europa Express | [KW10](fx602/KW10.prg) | [KW10](fx502/KW10.prg), [KW10D](fx502/KW10D.prg) | 710 | 35 |
| 11 | Schaufensterpuppen | [KW11](fx602/KW11.prg) | [KW11](fx502/KW11.prg), [KW11D](fx502/KW11D.prg) | 711 | 36 |

The listings were converted from the score by Claude Code. Create a WAV file,
e.g. `prg602 fx602/KW01.prg KW01.wav`, set the FA-1/FA-2 to MUSIC, start the
tape recorder and press P0.

## Sources

- [Casio VL-1 (Wikipedia)](https://en.wikipedia.org/wiki/Casio_VL-1)
- [Kraftwerk Music for the Casio VL-80 Pocket Calculator, 1981 (Flashbak)](https://flashbak.com/pocket-calculator-kraftwerk-sheet-music-478323/)
- [1981 Merchandise pocket calculator – Kraftwerk](https://twingokraftwerk.com/discographymirror/02/casio.htm)
- [When Kraftwerk Issued Their Own Pocket Calculator Synthesizer (Open Culture)](https://www.openculture.com/2019/06/when-kraftwerk-issued-their-own-pocket-calculator-synthesizer.html)
- [Casio VL-80 Operation Manual (manualslib)](https://www.manualslib.com/manual/734852/Casio-Vl-80.html)
