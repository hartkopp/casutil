# SURV30 - Vertical curve
# Surveying-30, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-30
# prg code converted from the original document by Claude Code
#
# P0: input the grades i1 and i2 (%), output i2 - i1. P1: input the
# design speed V, output the curve length L = |i2 - i1| V^2 / 360.
# P2: input L, output M = (i2 - i1) L / 800, then input x, output
# y = (i2 - i1) x^2 / 200L. All rounded to three decimals by P8.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 54
# @calculator 502
# @number 430

*** P0
AC HLT - 0 HLT = +/- Min3                                   # 8

*** P1
x^2 * MR3 ABS / 3 6 0 = GSBP8                               # 10

*** P2
Min5 * MR3 / 8 0 0 = GSBP8 HLT                              # 10
x^2 * MR3 / MR5 / 2 0 0 = GSBP8                             # 21

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
