# SURV11 - Solution of a triangle 1 (three sides known)
# Surveying-11, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-11
# prg code converted from the original document by Claude Code
#
# Input a, b and c repeatedly; output the angles alpha, beta, gamma
# (d.ms) and the area S = ab sin(gamma) / 2, rounded to four decimals.
# P1 calculates an angle by the law of cosines. DMS<- changes only
# the display, sin in line 7 uses gamma in degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 72
# @calculator 502
# @number 411

*** P0
DEG AC                                                      # 2
LBL1 HLT Min1 0                                             # 6
HLT Min2 0                                                  # 9
HLT Min3                                                    # 11
GSBP1 MR4 Min5 MR1 X<->M2 Min1                              # 17
GSBP1 1 8 0 - MR4 - MR5 = Min6 DMS<- HLT                    # 29
sin * MR1 * MR2 / 2 =                                       # 37
* 4 10^x + FRAC = INT / 4 10^x =                            # 48
GOTO1                                                       # 49

*** P1
( MR2 x^2 + MR3 x^2 - MR1 x^2 ) / 2                         # 12
/ MR2 / MR3 = cos-1 Min4 DMS<- HLT                          # 21
