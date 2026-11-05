# SURV23 - Intersection 1 (four points known)
# Surveying-23, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-23
# prg code converted from the original document by Claude Code
#
# P0: input the points A (X1, Y1) and B (X2, Y2) of the first line and
# C (X3, Y3), D (X4, Y4) of the second line repeatedly; output the
# intersection P (X, Y). P1: input A, B and C repeatedly; output the
# foot P of the perpendicular from C on AB. X and Y are rounded to
# three decimals by P8. P2 is the input of A, B and C, P3 the
# calculation of P.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 103
# @calculator 502
# @number 423

*** P0
AC                                                          # 1
LBL1 GSBP2 AC HLT - MR5 = Min7 0 HLT - MR6 = /              # 15
MR7 = Min8 GSBP3 GOTO1                                      # 20

*** P1
AC                                                          # 1
LBL1 GSBP2 MR4 +/- 1/x = Min8 GSBP3 GOTO1                   # 10

*** P2
HLT Min1 0 HLT Min2 0 HLT - MR1 = Min3 0 HLT -              # 14
MR2 = / MR3 = Min4 0 HLT Min5 0 HLT Min6                    # 26

*** P3
* MR5 - MR4 * MR1 - MR6 + MR2 = / (                         # 13
MR8 - MR4 ) = Min0 GSBP8 HLT MR0 - MR1                      # 24
= * MR4 + MR2 = GSBP8                                       # 31

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
