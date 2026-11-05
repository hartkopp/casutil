# SURV27 - Intersection 5 (circle and circle)
# Surveying-27, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-27
# prg code converted from the original document by Claude Code
#
# Input the centre (XA, YA) and radius rA of the first circle, the
# centre (XB, YB) and radius rB of the second circle repeatedly; output
# both intersections P1 (X, Y) and P2 (X, Y), rounded to three decimals
# by P8. P1 calculates one intersection from the angle in M6. Any angle
# unit works, as the angles are only used inside the program.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 93
# @calculator 502
# @number 427

*** P0
AC                                                          # 1
LBL1 HLT Min1 +/- Min4 0 HLT Min2 +/- Min5 0 HLT Min3 0     # 15
HLT M+4 0 HLT M+5 0 HLT Min6                                # 23
MR4 R->P MR5 = Min4 X<->Y Min5                              # 30
MR3 x^2 + MR4 x^2 - MR6 x^2 = / 2 /                         # 42
MR3 / MR4 = cos-1 Min4                                      # 48
+ MR5 = Min6 GSBP1 HLT                                      # 54
MR5 - MR4 = Min6 GSBP1 GOTO1                                # 61

*** P1
MR3 P->R MR6 = Min7 X<->Y Min8                              # 7
MR7 + MR1 = GSBP8 HLT                                       # 13
MR8 + MR2 = GSBP8                                           # 18

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
