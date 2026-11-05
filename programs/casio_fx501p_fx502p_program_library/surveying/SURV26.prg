# SURV26 - Intersection 4 (circle and line)
# Surveying-26, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-26
# prg code converted from the original document by Claude Code
#
# Input two points (X1, Y1), (X2, Y2) of the line, the centre (X3, Y3)
# and the radius r of the circle repeatedly; output both intersections
# A (X, Y) and B (X, Y), rounded to three decimals by P8. P1 calculates
# one intersection for the sign of the square root in M2.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 108
# @calculator 502
# @number 426

*** P0
AC                                                          # 1
LBL1 HLT Min1 0 HLT Min2 0 HLT - MR1 = Min3 0 HLT -         # 16
MR2 = / MR3 = Min4 0 HLT Min5 0 HLT Min6 0                  # 29
HLT x^2 Min7                                                # 32
MR4 x^2 Min8 + 1 = Min3                                     # 39
MR2 - MR6 = Min2 MR1 - MR5 = * MR4 -                        # 51
MR2 = Min1                                                  # 54
MR7 * MR3 - MR1 x^2 = SQR Min2                              # 63
GSBP1 HLT MR2 +/- Min2                                      # 68
GSBP1 GOTO1                                                 # 70

*** P1
MR4 * MR1 + MR2 = / MR3 = Min7 + MR5                        # 12
= GSBP8 HLT                                                 # 15
MR7 * MR4 - MR1 + MR6 = GSBP8                               # 24

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
