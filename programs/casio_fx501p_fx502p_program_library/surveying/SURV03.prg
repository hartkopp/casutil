# SURV03 - Branched traverse
# Surveying-3, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-3
# prg code converted from the original document by Claude Code
#
# Input the azimuth alpha0 and the coordinates XA, YA of the known
# point A, then repeatedly the angle theta and the distance l of each
# point; output its azimuth alpha = alpha0 + theta + 180 (- 360) and its
# coordinates X = XA + l cos alpha, Y = YA + l sin alpha. Angles d.mmss,
# P5 subtracts 360, P8 rounds to three decimals, P9 converts d.mmss to
# degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 96 (the sheet says 97, the step numbers of the lines add up
# to 96)
# @calculator 502
# @number 403

*** P0
DEG 3 6 0 MinF AC                                           # 6
HLT GSBP9 Min1 DMS<-                                        # 10
HLT Min2 0                                                  # 13
HLT Min3 0                                                  # 16
LBL1 HLT GSBP9 Min4 DMS<- HLT                               # 22
Min5 MR4 + MR1 + 1 8 0 =                                    # 31
x>=F GSBP5 x>=F GSBP5                                       # 35
Min4 DMS<- HLT                                              # 38
MR2 + MR5 * MR4 cos = GSBP8 HLT                             # 47
MR3 + MR5 * MR4 sin = GSBP8 GOTO1                           # 56

*** P5
- MRF =                                                     # 3

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22
