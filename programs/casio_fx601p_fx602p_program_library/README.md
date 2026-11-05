# CASIO Program Library FX-601P/FX-602P

The programs and music pieces of the CASIO "Program Library FX-601P/FX-602P"
as listings for `prg602`, so that owners of the original document do not need
to key them in. The descriptions, examples and sample data are only in the
original document, each listing names its pages.

Each line of a listing is a line of the program sheet, the comment behind it
is the step number of the sheet at the end of the line. `# @name` is the
number of the program, which the calculator shows while loading.

The listing follows the English sheet (the pieces in `music_jp` the Japanese
one), including its errors, so that it can be compared with the sheet while
keying it in. Where the sheet has an error,
the line is split at the error and the comment "fix:" behind the step number
gives the replacement of that line, e.g.:

```
MR07 10^x                                                   # 56 fix: MR07 x^y
6 - 1 ) ) / 2                                               # 63
```

The header of the listing describes the error, how it was found and where
the correct version is documented.

Create a WAV file and load it into the calculator, e.g.:

```
prg602 game/GAME01.prg GAME01.wav
```

Play `GAME01.wav` into the FA-1 or FA-2 and load it with `MODE 3 INV LOAD EXE`.
The music pieces are "all" files with the programs and the note data in the
registers.

## Mathematics

| Program | Title | Page |
|---|---|---|
| [MATH01](mathematics/MATH01.prg) | Prime factor analysis | 1 |
| [MATH02](mathematics/MATH02.prg) | Greatest common measure | 3 |
| [MATH03](mathematics/MATH03.prg) | Decimal - base-N conversion (n = 2 - 9) | 5 |
| [MATH04](mathematics/MATH04.prg) | Calculation of remainder | 7 |
| [MATH05](mathematics/MATH05.prg) | Polynomial calculations | 9 |
| [MATH06](mathematics/MATH06.prg) | Permutations and combinations | 11 |
| [MATH07](mathematics/MATH07.prg) | Complex arithmetics | 15 |
| [MATH08](mathematics/MATH08.prg) | Transformation of coordinates | 17 |
| [MATH09](mathematics/MATH09.prg) | 4-by-4 determinant | 19 |
| [MATH10](mathematics/MATH10.prg) | 3 variable linear equations | 21 |
| [MATH11](mathematics/MATH11.prg) | Solving a cubic equation by the Newton method | 23 |
| [MATH12](mathematics/MATH12.prg) | Solving an equation by the midpoint method | 25 |
| [MATH13](mathematics/MATH13.prg) | Definite integral by the Simpson's rule | 27 |
| [MATH14](mathematics/MATH14.prg) | Solving ordinary differential equation of the first order by the Runge-Kutta method | 29 |
| [MATH15](mathematics/MATH15.prg) | Bessel function of the first kind and n-th order | 31 |

## Electrical engineering

| Program | Title | Page |
|---|---|---|
| [EENG01](electrical_engineering/EENG01.prg) | Delta - Y conversion | 33 |
| [EENG02](electrical_engineering/EENG02.prg) | Impedance of series and parallel circuits | 35 |
| [EENG03](electrical_engineering/EENG03.prg) | Impedance of series resonance circuit | 37 |
| [EENG04](electrical_engineering/EENG04.prg) | Design of an active low-pass filter | 39 |
| [EENG05](electrical_engineering/EENG05.prg) | Design of an active high-pass filter | 41 |
| [EENG06](electrical_engineering/EENG06.prg) | Design of an active band-pass filter | 43 |
| [EENG07](electrical_engineering/EENG07.prg) | Impedance of transmission line | 45 |
| [EENG08](electrical_engineering/EENG08.prg) | T- and pi-attenuators | 47 |
| [EENG09](electrical_engineering/EENG09.prg) | Minimum loss matching | 49 |
| [EENG10](electrical_engineering/EENG10.prg) | Distributed constant circuit | 51 |
| [EENG11](electrical_engineering/EENG11.prg) | Transistor amplifier | 53 |
| [EENG12](electrical_engineering/EENG12.prg) | Four-terminal parameter conversion (Z, Y, G, H, F) | 59 |

## Mechanics

| Program | Title | Page |
|---|---|---|
| [MECH01](mechanics/MECH01.prg) | Cantilever under concentrated load | 67 |
| [MECH02](mechanics/MECH02.prg) | Cantilever under distributed load | 69 |
| [MECH03](mechanics/MECH03.prg) | Simple beam under concentrated load | 71 |
| [MECH04](mechanics/MECH04.prg) | Simple beam under distributed load | 73 |
| [MECH05](mechanics/MECH05.prg) | Beam fixed at both ends under concentrated load | 75 |
| [MECH06](mechanics/MECH06.prg) | Beam fixed at both ends under distributed load | 77 |
| [MECH07](mechanics/MECH07.prg) | Free vibration | 79 |
| [MECH08](mechanics/MECH08.prg) | Forced vibration | 81 |
| [MECH09](mechanics/MECH09.prg) | Design of coil spring | 83 |
| [MECH10](mechanics/MECH10.prg) | Thermal stress | 85 |

## Physics/chemistry

| Program | Title | Page |
|---|---|---|
| [PHYS01](physics_chemistry/PHYS01.prg) | Simple pendulum | 87 |
| [PHYS02](physics_chemistry/PHYS02.prg) | Parabolic movement | 89 |
| [PHYS03](physics_chemistry/PHYS03.prg) | Thermal conduction through layers | 91 |
| [PHYS04](physics_chemistry/PHYS04.prg) | First- and second-order reaction speeds | 93 |
| [PHYS05](physics_chemistry/PHYS05.prg) | Equation of state of ideal gas | 95 |

## Statistics

| Program | Title | Page |
|---|---|---|
| [STAT01](statistics/STAT01.prg) | Geometrical and harmonic means | 97 |
| [STAT02](statistics/STAT02.prg) | 6-month moving average | 99 |
| [STAT03](statistics/STAT03.prg) | n-month moving average (n < 77) | 101 |
| [STAT04](statistics/STAT04.prg) | Correlation coefficient | 103 |
| [STAT05](statistics/STAT05.prg) | Spearman's coefficient of rank correlation | 105 |
| [STAT06](statistics/STAT06.prg) | Regression analysis (linear, exponential, logarithmic, power) | 107 |
| [STAT07](statistics/STAT07.prg) | Quadratic regression analysis | 109 |
| [STAT08](statistics/STAT08.prg) | Binomial and Poisson distributions | 111 |
| [STAT09](statistics/STAT09.prg) | Normal distribution | 113 |
| [STAT10](statistics/STAT10.prg) | Chi-square distribution | 115 |
| [STAT11](statistics/STAT11.prg) | F-distribution | 117 |
| [STAT12](statistics/STAT12.prg) | t-distribution | 119 |
| [STAT13](statistics/STAT13.prg) | F-test | 121 |
| [STAT14](statistics/STAT14.prg) | t-test | 123 |
| [STAT15](statistics/STAT15.prg) | 2-by-2 contingency table | 125 |
| [STAT16](statistics/STAT16.prg) | m-by-n contingency table | 127 |
| [STAT17](statistics/STAT17.prg) | Analysis of variance with one-way layout | 129 |
| [STAT18](statistics/STAT18.prg) | Analysis of variance with two-way layout | 131 |
| [STAT19](statistics/STAT19.prg) | Multiple correlation coefficient | 133 |

## Medicine

| Program | Title | Page |
|---|---|---|
| [MED01](medicine/MED01.prg) | Removal of urea | 135 |
| [MED02](medicine/MED02.prg) | Surface area of a human body | 137 |
| [MED03](medicine/MED03.prg) | Indication of red corpuscle | 139 |
| [MED04](medicine/MED04.prg) | Acidity of blood | 141 |
| [MED05](medicine/MED05.prg) | Saturated and normal oxygen contents of blood | 143 |

## Banking

| Program | Title | Page |
|---|---|---|
| [BANK01](banking/BANK01.prg) | Calculation for loan-repayment I (equally divided monthly repayment) | 145 |
| [BANK02](banking/BANK02.prg) | Calculation for loan-repayment II (interest on equally divided monthly repayment) | 147 |
| [BANK03](banking/BANK03.prg) | Calculation for loan-repayment III (equally divided monthly repayment plus extra at bonus times twice a year) | 149 |
| [BANK04](banking/BANK04.prg) | Calculation for installment plan | 151 |
| [BANK05](banking/BANK05.prg) | Calculation of compound annual interest | 153 |
| [BANK06](banking/BANK06.prg) | Calculation for discounting commercial bills (by annual interest basis) | 155 |
| [BANK07](banking/BANK07.prg) | Calculating for depreciation | 157 |
| [BANK08](banking/BANK08.prg) | Calculation of aggregate classification and prorating | 159 |
| [BANK09](banking/BANK09.prg) | Horizontal/vertical aggregate calculations | 161 |

## Navigation

| Program | Title | Page |
|---|---|---|
| [NAV01](navigation/NAV01.prg) | Astronomical observation | 163 |
| [NAV02](navigation/NAV02.prg) | Great circle navigation | 165 |
| [NAV03](navigation/NAV03.prg) | Rhumb line navigation | 167 |

## Game

| Program | Title | Page |
|---|---|---|
| [GAME01](game/GAME01.prg) | Secret number game | 169 |
| [GAME02](game/GAME02.prg) | Gopher game | 171 |
| [GAME03](game/GAME03.prg) | Shuffle-number game | 173 |
| [GAME04](game/GAME04.prg) | Hit-and-blow game | 175 |
| [GAME05](game/GAME05.prg) | Last-stone game I | 177 |
| [GAME06](game/GAME06.prg) | Last-stone game II | 179 |
| [GAME07](game/GAME07.prg) | Search-bug game | 183 |

## Music

| Program | Title | Page |
|---|---|---|
| [MUS01](music/MUS01.prg) | Ogonek | 187 |
| [MUS02](music/MUS02.prg) | Für Elise | 189 |
| [MUS03](music/MUS03.prg) | Romance de amor | 191 |
| [MUS04](music/MUS04.prg) | Tarantella napoletana | 195 |

## Music of the Japanese edition

The Japanese edition of the library has partly other music pieces. The two
pieces, which are missing in the English edition, are in `music_jp`, numbered
as in the Japanese edition:

| Program | Title | Page |
|---|---|---|
| [JMUS01](music_jp/JMUS01.prg) | Sakura sakura (さくらさくら) | 187 |
| JMUS02 | Tomoshibi (ともしび), the same program and note data as MUS01 Ogonek | 189 |
| [JMUS03](music_jp/JMUS03.prg) | Kojo no tsuki (荒城の月) | 191 |

Music-4 to Music-6 of the Japanese edition are Für Elise (MUS02), Romance
de amor as "Kinjirareta asobi" (MUS03) and an older version of Tarantella
napoletana with dotted notes (MUS04). The Japanese edition gives the tempo
codes for the tempo table 28..280 of the FX-501P/FX-502P, the English one
for 40..400 of the FX-601P/FX-602P.

The programs were converted from the original document by Claude Code. The step
numbers of each listing are checked against the program sheet, the game and
music programs also against recordings of these programs from cassettes.
