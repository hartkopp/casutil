# SURV05 - Open traverse 2
# Surveying-5, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-5
# prg code converted from the original document by Claude Code
#
# Like SURV04, but with all values of the traverse table: input the
# azimuth and the coordinates X, Y of the first point, then repeatedly
# the measured angle and the distance; output the azimuth, cos, sin,
# dX, dY (rounded to three decimals) and the coordinates X, Y of the
# next point. Angles d.mmss, P4 subtracts 360, P8 rounds, P9 converts
# d.mmss to degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 105
# @calculator 502
# @number 405

*** P0
DEG 3 6 0 MinF AC                                           # 6
HLT GSBP9 Min1 DMS<-                                        # 10
HLT Min2 0                                                  # 13
HLT Min3 0                                                  # 16
LBL1 HLT GSBP9 + MR1 + 1 8 0 =                              # 26
x>=F GSBP4 x>=F GSBP4                                       # 30
Min1 DMS<- HLT                                              # 33
Min4 * MR1 cos HLT = Min5                                   # 40
MR4 * MR1 sin HLT = Min6                                    # 47
MR5 GSBP8 HLT + MR2 = Min2                                  # 54
MR6 GSBP8 HLT + MR3 = Min3                                  # 61
MR2 HLT MR3 GOTO1                                           # 65

*** P4
- MRF =                                                     # 3

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22
