# CASIO Program Library FX-501P/FX-502P

The programs and music pieces of the Japanese edition of the CASIO "Program
Library FX-501P/FX-502P" as listings for `prg602`, so that owners of the
original document do not need to key them in. The descriptions, examples and
sample data are only in the original document, each listing names its sheet.

Each line of a listing is a line of the program sheet, the comment behind it
is the step number of the sheet at the end of the line. `# @number` is the
file number: 100 for the first chapter plus 50 for each further chapter plus
the number of the program in its chapter (Mathematics 101.., Electrical
engineering 151.., Mechanics 201.., ..., Surveying 401..438).

The listing follows the sheet, including its errors, so that it can be
compared with the sheet while keying it in. Where the sheet has an error,
the line is split at the error and the comment "fix:" behind the step number
gives the replacement of that line, e.g.:

```
MR7 * MR3                                                   # 25 fix: MR7
* ( 3 * GSBP2 tan-1 HLT                                     # 32
```

The header of the listing describes the error, how it was found and where
the correct version is documented.

Create a WAV file and load it into the calculator, e.g.:

```
prg602 mathematics/MATH01.prg MATH01.wav
```

Play `MATH01.wav` into the FA-1 and load it into the calculator; the file
number identifies the file on the tape. The FX-501P/FX-502P save programs
and data registers in separate files, so the music pieces consist of a program (`MUSnn.prg`) and a data file with the
note and tempo data (`MUSnnD.prg`) with the same file number.

The column FX-602P names the version of the program in the
[CASIO Program Library FX-601P/FX-602P](../casio_fx601p_fx602p_program_library/README.md).
Each program was compared with that version, the header of the listing
describes the differences. Most FX-602P versions add prompts and alpha
output, the formulas are the same. The comparison found errors on both
sides:

- MATH07: the Japanese FX-602P sheet has R->P instead of P->R in P9, the
  FX-502P and the English FX-602P sheet agree on P->R.
- EENG11 (fix): the FX-502P sheet has two errors (-h21 instead of
  -(1 + h21) and h22 * Ze instead of h22 + 1/Ze), its example was
  calculated with them.
- MECH03 (fix): the slope formula of the FX-502P sheet lacks the factor
  1/l, its example was calculated with it.
- MUS06 (fix): two 16th notes in P0, the German edition and the FX-602P
  version have eighth notes there.
- MED05 (FX-602P): a misread in the FX-602P listing (Min02 instead of MR02).
- BANK03 (FX-602P, fix): both FX-602P sheets have / 2 INV x^y = instead
  of / 2 10^x =, the English one also 10^x 6 instead of x^y 6, the
  FX-502P sheet and the examples confirm 10^x and x^y.
- STAT04 and MED02 (FX-602P): wrong register and parameter descriptions in
  the headers of the FX-602P listings.

The German edition of the FX-501P/FX-502P library has a smaller selection
(12 programs in Mathematics, 15 in Statistics, 6 in Medicine, 5 in Banking,
25 in Surveying and 4 music pieces: Ogonek, Romance de amor, Für Elise and
Tarantella), but no programs that are missing in the Japanese edition. It
was used to check the differences:

- It confirms the Japanese sheets of EENG11, MECH03, MED05, PHYS03, GAME06,
  GAME07 and the music pieces MUS04 to MUS06, and the total of 101 steps of
  NAV02 (the Japanese sheet says 104).
- BANK03 is a revised version with the same keys at the disputed places.
- MECH05 lacks tan-1 for the angle, the Japanese sheet is right.

Some sheets are marked "for FX-502P" (FX-502P用), the program does not fit
into the 128 steps of the FX-501P. Some other sheets describe which parts
of the program fit into the FX-501P.

## Mathematics

| No. | Program | Title | FX-602P |
|---|---|---|---|
| 101 | [MATH01](mathematics/MATH01.prg) | Prime factor analysis | [MATH01](../casio_fx601p_fx602p_program_library/mathematics/MATH01.prg) |
| 102 | [MATH02](mathematics/MATH02.prg) | Greatest common measure | [MATH02](../casio_fx601p_fx602p_program_library/mathematics/MATH02.prg) |
| 103 | [MATH03](mathematics/MATH03.prg) | Decimal - base-N conversion (n = 2 - 9) | [MATH03](../casio_fx601p_fx602p_program_library/mathematics/MATH03.prg) |
| 104 | [MATH04](mathematics/MATH04.prg) | Calculation of remainder | [MATH04](../casio_fx601p_fx602p_program_library/mathematics/MATH04.prg) |
| 105 | [MATH05](mathematics/MATH05.prg) | Polynomial calculations | [MATH05](../casio_fx601p_fx602p_program_library/mathematics/MATH05.prg) |
| 106 | [MATH06](mathematics/MATH06.prg) | Permutations and combinations | [MATH06](../casio_fx601p_fx602p_program_library/mathematics/MATH06.prg) |
| 107 | [MATH07](mathematics/MATH07.prg) | Complex arithmetics | [MATH07](../casio_fx601p_fx602p_program_library/mathematics/MATH07.prg) |
| 108 | [MATH08](mathematics/MATH08.prg) | Vector calculations | – |
| 109 | [MATH09](mathematics/MATH09.prg) | Transformation of coordinates | [MATH08](../casio_fx601p_fx602p_program_library/mathematics/MATH08.prg) |
| 110 | [MATH10](mathematics/MATH10.prg) | 4-by-4 determinant | [MATH09](../casio_fx601p_fx602p_program_library/mathematics/MATH09.prg) |
| 111 | [MATH11](mathematics/MATH11.prg) | 3 variable linear equations | [MATH10](../casio_fx601p_fx602p_program_library/mathematics/MATH10.prg) |
| 112 | [MATH12](mathematics/MATH12.prg) | Cubic equation | – |
| 113 | [MATH13](mathematics/MATH13.prg) | Solving a cubic equation by the Newton method | [MATH11](../casio_fx601p_fx602p_program_library/mathematics/MATH11.prg) |
| 114 | [MATH14](mathematics/MATH14.prg) | Solving an equation by the midpoint method | [MATH12](../casio_fx601p_fx602p_program_library/mathematics/MATH12.prg) |
| 115 | [MATH15](mathematics/MATH15.prg) | Definite integral by the Simpson's rule | [MATH13](../casio_fx601p_fx602p_program_library/mathematics/MATH13.prg) |
| 116 | [MATH16](mathematics/MATH16.prg) | Solving ordinary differential equation of the first order by the Runge-Kutta method | [MATH14](../casio_fx601p_fx602p_program_library/mathematics/MATH14.prg) |
| 117 | [MATH17](mathematics/MATH17.prg) | Bessel function of the first kind and n-th order | [MATH15](../casio_fx601p_fx602p_program_library/mathematics/MATH15.prg) |

## Electrical engineering

| No. | Program | Title | FX-602P |
|---|---|---|---|
| 151 | [EENG01](electrical_engineering/EENG01.prg) | Delta - Y conversion | [EENG01](../casio_fx601p_fx602p_program_library/electrical_engineering/EENG01.prg) |
| 152 | [EENG02](electrical_engineering/EENG02.prg) | Impedance of series and parallel circuits | [EENG02](../casio_fx601p_fx602p_program_library/electrical_engineering/EENG02.prg) |
| 153 | [EENG03](electrical_engineering/EENG03.prg) | Impedance of series resonance circuit | [EENG03](../casio_fx601p_fx602p_program_library/electrical_engineering/EENG03.prg) |
| 154 | [EENG04](electrical_engineering/EENG04.prg) | Design of an active low-pass filter | [EENG04](../casio_fx601p_fx602p_program_library/electrical_engineering/EENG04.prg) |
| 155 | [EENG05](electrical_engineering/EENG05.prg) | Design of an active high-pass filter | [EENG05](../casio_fx601p_fx602p_program_library/electrical_engineering/EENG05.prg) |
| 156 | [EENG06](electrical_engineering/EENG06.prg) | Design of an active band-pass filter | [EENG06](../casio_fx601p_fx602p_program_library/electrical_engineering/EENG06.prg) |
| 157 | [EENG07](electrical_engineering/EENG07.prg) | Impedance of transmission line | [EENG07](../casio_fx601p_fx602p_program_library/electrical_engineering/EENG07.prg) |
| 158 | [EENG08](electrical_engineering/EENG08.prg) | T- and pi-attenuators | [EENG08](../casio_fx601p_fx602p_program_library/electrical_engineering/EENG08.prg) |
| 159 | [EENG09](electrical_engineering/EENG09.prg) | Minimum loss matching | [EENG09](../casio_fx601p_fx602p_program_library/electrical_engineering/EENG09.prg) |
| 160 | [EENG10](electrical_engineering/EENG10.prg) | Distributed constant circuit | [EENG10](../casio_fx601p_fx602p_program_library/electrical_engineering/EENG10.prg) |
| 161 | [EENG11](electrical_engineering/EENG11.prg) | Transistor amplifier | [EENG11](../casio_fx601p_fx602p_program_library/electrical_engineering/EENG11.prg) |
| 162 | [EENG12](electrical_engineering/EENG12.prg) | Four-terminal parameter conversion (Z, Y, G, H, F) | [EENG12](../casio_fx601p_fx602p_program_library/electrical_engineering/EENG12.prg) |

## Mechanics

| No. | Program | Title | FX-602P |
|---|---|---|---|
| 201 | [MECH01](mechanics/MECH01.prg) | Cantilever under concentrated load | [MECH01](../casio_fx601p_fx602p_program_library/mechanics/MECH01.prg) |
| 202 | [MECH02](mechanics/MECH02.prg) | Cantilever under distributed load | [MECH02](../casio_fx601p_fx602p_program_library/mechanics/MECH02.prg) |
| 203 | [MECH03](mechanics/MECH03.prg) | Simple beam under concentrated load | [MECH03](../casio_fx601p_fx602p_program_library/mechanics/MECH03.prg) |
| 204 | [MECH04](mechanics/MECH04.prg) | Simple beam under distributed load | [MECH04](../casio_fx601p_fx602p_program_library/mechanics/MECH04.prg) |
| 205 | [MECH05](mechanics/MECH05.prg) | Beam fixed at both ends under concentrated load | [MECH05](../casio_fx601p_fx602p_program_library/mechanics/MECH05.prg) |
| 206 | [MECH06](mechanics/MECH06.prg) | Beam fixed at both ends under distributed load | [MECH06](../casio_fx601p_fx602p_program_library/mechanics/MECH06.prg) |
| 207 | [MECH07](mechanics/MECH07.prg) | Free vibration | [MECH07](../casio_fx601p_fx602p_program_library/mechanics/MECH07.prg) |
| 208 | [MECH08](mechanics/MECH08.prg) | Forced vibration | [MECH08](../casio_fx601p_fx602p_program_library/mechanics/MECH08.prg) |
| 209 | [MECH09](mechanics/MECH09.prg) | Displacement, velocity and acceleration of the piston of a piston-crank engine | – |
| 210 | [MECH10](mechanics/MECH10.prg) | Horsepower and shaft torque of an internal combustion engine | – |
| 211 | [MECH11](mechanics/MECH11.prg) | Design of coil spring | [MECH09](../casio_fx601p_fx602p_program_library/mechanics/MECH09.prg) |
| 212 | [MECH12](mechanics/MECH12.prg) | Thermal stress | [MECH10](../casio_fx601p_fx602p_program_library/mechanics/MECH10.prg) |
| 213 | [MECH13](mechanics/MECH13.prg) | Length of belt | – |

## Physics/chemistry

| No. | Program | Title | FX-602P |
|---|---|---|---|
| 251 | [PHYS01](physics_chemistry/PHYS01.prg) | Simple pendulum | [PHYS01](../casio_fx601p_fx602p_program_library/physics_chemistry/PHYS01.prg) |
| 252 | [PHYS02](physics_chemistry/PHYS02.prg) | Parabolic movement | [PHYS02](../casio_fx601p_fx602p_program_library/physics_chemistry/PHYS02.prg) |
| 253 | [PHYS03](physics_chemistry/PHYS03.prg) | Thermal conduction through layers | [PHYS03](../casio_fx601p_fx602p_program_library/physics_chemistry/PHYS03.prg) |
| 254 | [PHYS04](physics_chemistry/PHYS04.prg) | First- and second-order reaction speeds | [PHYS04](../casio_fx601p_fx602p_program_library/physics_chemistry/PHYS04.prg) |
| 255 | [PHYS05](physics_chemistry/PHYS05.prg) | Equation of state of ideal gas | [PHYS05](../casio_fx601p_fx602p_program_library/physics_chemistry/PHYS05.prg) |

## Statistics

| No. | Program | Title | FX-602P |
|---|---|---|---|
| 301 | [STAT01](statistics/STAT01.prg) | Deviation value | – |
| 302 | [STAT02](statistics/STAT02.prg) | Geometrical and harmonic means | [STAT01](../casio_fx601p_fx602p_program_library/statistics/STAT01.prg) |
| 303 | [STAT03](statistics/STAT03.prg) | 6-month moving average | [STAT02](../casio_fx601p_fx602p_program_library/statistics/STAT02.prg) |
| 304 | [STAT04](statistics/STAT04.prg) | 12-month moving average | – |
| 304 | [STAT04N](statistics/STAT04N.prg) | n-month moving average (n = 2..19) | [STAT03](../casio_fx601p_fx602p_program_library/statistics/STAT03.prg) |
| 305 | [STAT05](statistics/STAT05.prg) | Correlation coefficient | [STAT04](../casio_fx601p_fx602p_program_library/statistics/STAT04.prg) |
| 306 | [STAT06](statistics/STAT06.prg) | Spearman's coefficient of rank correlation | [STAT05](../casio_fx601p_fx602p_program_library/statistics/STAT05.prg) |
| 307 | [STAT07](statistics/STAT07.prg) | Regression analysis (linear, exponential, logarithmic, power) | [STAT06](../casio_fx601p_fx602p_program_library/statistics/STAT06.prg) |
| 308 | [STAT08](statistics/STAT08.prg) | Quadratic regression analysis | [STAT07](../casio_fx601p_fx602p_program_library/statistics/STAT07.prg) |
| 309 | [STAT09](statistics/STAT09.prg) | Binomial and Poisson distributions | [STAT08](../casio_fx601p_fx602p_program_library/statistics/STAT08.prg) |
| 310 | [STAT10](statistics/STAT10.prg) | Normal distribution | [STAT09](../casio_fx601p_fx602p_program_library/statistics/STAT09.prg) |
| 311 | [STAT11](statistics/STAT11.prg) | Chi-square distribution | [STAT10](../casio_fx601p_fx602p_program_library/statistics/STAT10.prg) |
| 312 | [STAT12](statistics/STAT12.prg) | F-distribution | [STAT11](../casio_fx601p_fx602p_program_library/statistics/STAT11.prg) |
| 313 | [STAT13](statistics/STAT13.prg) | t-distribution | [STAT12](../casio_fx601p_fx602p_program_library/statistics/STAT12.prg) |
| 314 | [STAT14](statistics/STAT14.prg) | F-test | [STAT13](../casio_fx601p_fx602p_program_library/statistics/STAT13.prg) |
| 315 | [STAT15](statistics/STAT15.prg) | t-test | [STAT14](../casio_fx601p_fx602p_program_library/statistics/STAT14.prg) |
| 316 | [STAT16](statistics/STAT16.prg) | 2-by-2 contingency table | [STAT15](../casio_fx601p_fx602p_program_library/statistics/STAT15.prg) |
| 317 | [STAT17](statistics/STAT17.prg) | m-by-n contingency table | [STAT16](../casio_fx601p_fx602p_program_library/statistics/STAT16.prg) |
| 318 | [STAT18](statistics/STAT18.prg) | Analysis of variance with one-way layout | [STAT17](../casio_fx601p_fx602p_program_library/statistics/STAT17.prg) |
| 319 | [STAT19](statistics/STAT19.prg) | Analysis of variance with two-way layout | [STAT18](../casio_fx601p_fx602p_program_library/statistics/STAT18.prg) |
| 320 | [STAT20](statistics/STAT20.prg) | Multiple correlation coefficient | [STAT19](../casio_fx601p_fx602p_program_library/statistics/STAT19.prg) |

## Medicine

| No. | Program | Title | FX-602P |
|---|---|---|---|
| 351 | [MED01](medicine/MED01.prg) | Biorhythm | – |
| 352 | [MED02](medicine/MED02.prg) | Removal of urea | [MED01](../casio_fx601p_fx602p_program_library/medicine/MED01.prg) |
| 353 | [MED03](medicine/MED03.prg) | Surface area of a human body | [MED02](../casio_fx601p_fx602p_program_library/medicine/MED02.prg) |
| 354 | [MED04](medicine/MED04.prg) | Indication of red corpuscle | [MED03](../casio_fx601p_fx602p_program_library/medicine/MED03.prg) |
| 355 | [MED05](medicine/MED05.prg) | Acidity of blood | [MED04](../casio_fx601p_fx602p_program_library/medicine/MED04.prg) |
| 356 | [MED06](medicine/MED06.prg) | Saturated and normal oxygen contents of blood | [MED05](../casio_fx601p_fx602p_program_library/medicine/MED05.prg) |
| 357 | [MED07](medicine/MED07.prg) | Discomfort index | – |

## Surveying

The chapter Surveying (測量) has no counterpart in the FX-601P/FX-602P
library. All its programs reproduce the examples of their sheets.

| No. | Program | Title | FX-602P |
|---|---|---|---|
| 401 | [SURV01](surveying/SURV01.prg) | Addition, subtraction, multiplication and division of angles | – |
| 402 | [SURV02](surveying/SURV02.prg) | Coordinates from azimuth and distance | – |
| 403 | [SURV03](surveying/SURV03.prg) | Branched traverse | – |
| 404 | [SURV04](surveying/SURV04.prg) | Open traverse 1 | – |
| 405 | [SURV05](surveying/SURV05.prg) | Open traverse 2 | – |
| 406 | [SURV06](surveying/SURV06.prg) | Inverse calculation (single, radial) | – |
| 407 | [SURV07](surveying/SURV07.prg) | Inverse calculation (continuous) | – |
| 408 | [SURV08](surveying/SURV08.prg) | Triangle 1 (third side from two sides and the included angle) | – |
| 409 | [SURV09](surveying/SURV09.prg) | Triangle 2 (area from two sides and the included angle) | – |
| 410 | [SURV10](surveying/SURV10.prg) | Triangle 3 (area and heights from three sides) | – |
| 411 | [SURV11](surveying/SURV11.prg) | Solution of a triangle 1 (three sides known) | – |
| 412 | [SURV12](surveying/SURV12.prg) | Solution of a triangle 2 (two sides and the included angle known) | – |
| 413 | [SURV13](surveying/SURV13.prg) | Solution of a triangle 3 (one side and the two adjacent angles known) | – |
| 414 | [SURV14](surveying/SURV14.prg) | Area by three sides (triangulated area) | – |
| 415 | [SURV15](surveying/SURV15.prg) | Area from coordinates | – |
| 416 | [SURV16](surveying/SURV16.prg) | Area from angles and distances | – |
| 417 | [SURV17](surveying/SURV17.prg) | Closed traverse (angle closing error) | – |
| 418 | [SURV18](surveying/SURV18.prg) | Closed traverse (closing error, precision, adjustment) | – |
| 419 | [SURV19](surveying/SURV19.prg) | Stadia calculation | – |
| 420 | [SURV20](surveying/SURV20.prg) | Coordinates of an intermediate point | – |
| 421 | [SURV21](surveying/SURV21.prg) | Perpendicular and distance 1 (three points known) | – |
| 422 | [SURV22](surveying/SURV22.prg) | Perpendicular and distance 2 (two points and one azimuth known) | – |
| 423 | [SURV23](surveying/SURV23.prg) | Intersection 1 (four points known) | – |
| 424 | [SURV24](surveying/SURV24.prg) | Intersection 2 (three points and one azimuth known) | – |
| 425 | [SURV25](surveying/SURV25.prg) | Intersection 3 (two points and two azimuths known) | – |
| 426 | [SURV26](surveying/SURV26.prg) | Intersection 4 (circle and line) | – |
| 427 | [SURV27](surveying/SURV27.prg) | Intersection 5 (circle and circle) | – |
| 428 | [SURV28](surveying/SURV28.prg) | Simple curve | – |
| 429 | [SURV29](surveying/SURV29.prg) | Area and arc of a circular segment from chord and radius | – |
| 430 | [SURV30](surveying/SURV30.prg) | Vertical curve | – |
| 431 | [SURV31](surveying/SURV31.prg) | Corner point of a street corner 1 (0 < theta < 90) | – |
| 432 | [SURV32](surveying/SURV32.prg) | Corner point of a street corner 2 (90 < theta < 180) | – |
| 433 | [SURV33](surveying/SURV33.prg) | Area by offsets (trapezoidal rule) | – |
| 434 | [SURV34](surveying/SURV34.prg) | Corner cut-off | – |
| 435 | [SURV35](surveying/SURV35.prg) | Division of a trapezoid area | – |
| 436 | [SURV36](surveying/SURV36.prg) | Partition of a lot 1 (parallel to the opposite side) | – |
| 437 | [SURV37](surveying/SURV37.prg) | Partition of a lot 2 (one point fixed) | – |
| 438 | [SURV38](surveying/SURV38.prg) | Partition of a lot 3 (angle fixed) | – |

## Banking

| No. | Program | Title | FX-602P |
|---|---|---|---|
| 451 | [BANK01](banking/BANK01.prg) | Calculation for loan-repayment I (equally divided monthly repayment) | [BANK01](../casio_fx601p_fx602p_program_library/banking/BANK01.prg) |
| 452 | [BANK02](banking/BANK02.prg) | Calculation for loan-repayment II (interest on equally divided monthly repayment) | [BANK02](../casio_fx601p_fx602p_program_library/banking/BANK02.prg) |
| 453 | [BANK03](banking/BANK03.prg) | Calculation for loan-repayment III (equally divided monthly repayment plus extra at bonus times twice a year) | [BANK03](../casio_fx601p_fx602p_program_library/banking/BANK03.prg) |
| 454 | [BANK04](banking/BANK04.prg) | Calculation for installment plan | [BANK04](../casio_fx601p_fx602p_program_library/banking/BANK04.prg) |
| 455 | [BANK05](banking/BANK05.prg) | Calculation of compound annual interest | [BANK05](../casio_fx601p_fx602p_program_library/banking/BANK05.prg) |
| 456 | [BANK06](banking/BANK06.prg) | Calculation for discounting commercial bills (by annual interest basis) | [BANK06](../casio_fx601p_fx602p_program_library/banking/BANK06.prg) |
| 457 | [BANK07](banking/BANK07.prg) | Calculating for depreciation | [BANK07](../casio_fx601p_fx602p_program_library/banking/BANK07.prg) |
| 458 | [BANK08](banking/BANK08.prg) | Calendar calculation (number of days, date, weekday) | – |
| 459 | [BANK09](banking/BANK09.prg) | Calculation of aggregate classification and prorating | [BANK08](../casio_fx601p_fx602p_program_library/banking/BANK08.prg) |
| 460 | [BANK10](banking/BANK10.prg) | Horizontal/vertical aggregate calculations | [BANK09](../casio_fx601p_fx602p_program_library/banking/BANK09.prg) |
| 461 | [BANK11](banking/BANK11.prg) | Money denomination calculation | – |

## Navigation

| No. | Program | Title | FX-602P |
|---|---|---|---|
| 501 | [NAV01](navigation/NAV01.prg) | Astronomical observation | [NAV01](../casio_fx601p_fx602p_program_library/navigation/NAV01.prg) |
| 502 | [NAV02](navigation/NAV02.prg) | Great circle navigation | [NAV02](../casio_fx601p_fx602p_program_library/navigation/NAV02.prg) |
| 503 | [NAV03](navigation/NAV03.prg) | Rhumb line navigation | [NAV03](../casio_fx601p_fx602p_program_library/navigation/NAV03.prg) |

## Game

| No. | Program | Title | FX-602P |
|---|---|---|---|
| 551 | [GAME01](game/GAME01.prg) | Secret number game | [GAME01](../casio_fx601p_fx602p_program_library/game/GAME01.prg) |
| 552 | [GAME02](game/GAME02.prg) | Artillery game | – |
| 553 | [GAME03](game/GAME03.prg) | Gopher game | [GAME02](../casio_fx601p_fx602p_program_library/game/GAME02.prg) |
| 554 | [GAME04](game/GAME04.prg) | Shuffle-number game (reverse) | [GAME03](../casio_fx601p_fx602p_program_library/game/GAME03.prg) |
| 555 | [GAME05](game/GAME05.prg) | Hit-and-blow game | [GAME04](../casio_fx601p_fx602p_program_library/game/GAME04.prg) |
| 556 | [GAME06](game/GAME06.prg) | Last-stone game I | [GAME05](../casio_fx601p_fx602p_program_library/game/GAME05.prg) |
| 557 | [GAME07](game/GAME07.prg) | Last-stone game II | [GAME06](../casio_fx601p_fx602p_program_library/game/GAME06.prg) |
| 558 | [GAME08](game/GAME08.prg) | Search-bug game | [GAME07](../casio_fx601p_fx602p_program_library/game/GAME07.prg) |

## Music

| No. | Program | Title | FX-602P |
|---|---|---|---|
| 601 | [MUS01](music/MUS01.prg) | Sakura sakura (さくらさくら) | [JMUS01](../casio_fx601p_fx602p_program_library/music_jp/JMUS01.prg) |
| 601 | [MUS01D](music/MUS01D.prg) | Sakura sakura (さくらさくら), note and tempo data |  |
| 602 | [MUS02](music/MUS02.prg) | Tomoshibi (ともしび) | [MUS01](../casio_fx601p_fx602p_program_library/music/MUS01.prg) |
| 602 | [MUS02D](music/MUS02D.prg) | Tomoshibi (ともしび), note and tempo data |  |
| 603 | [MUS03](music/MUS03.prg) | Kojo no tsuki (荒城の月) | [JMUS03](../casio_fx601p_fx602p_program_library/music_jp/JMUS03.prg) |
| 603 | [MUS03D](music/MUS03D.prg) | Kojo no tsuki (荒城の月), note and tempo data |  |
| 604 | [MUS04](music/MUS04.prg) | Für Elise (エリーゼのために) | [MUS02](../casio_fx601p_fx602p_program_library/music/MUS02.prg) |
| 604 | [MUS04D](music/MUS04D.prg) | Für Elise (エリーゼのために), note and tempo data |  |
| 605 | [MUS05](music/MUS05.prg) | Kinjirareta asobi (禁じられた遊び), Romance de amor | [MUS03](../casio_fx601p_fx602p_program_library/music/MUS03.prg) |
| 605 | [MUS05D](music/MUS05D.prg) | Kinjirareta asobi (禁じられた遊び), note and tempo data |  |
| 606 | [MUS06](music/MUS06.prg) | Tarantella napoletana (ナポリタン・タランテラ) | [MUS04](../casio_fx601p_fx602p_program_library/music/MUS04.prg) |
| 606 | [MUS06D](music/MUS06D.prg) | Tarantella napoletana (ナポリタン・タランテラ), note and tempo data |  |

The programs were converted from the original document by Claude Code. The step
numbers of each listing are checked against the program sheet, the programs of
the chapter Surveying also against the examples of their sheets.
