# SURV04 - Open traverse 1
# Surveying-4, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-4
# prg code converted from the original document by Claude Code
#
# Input the azimuth alpha0 and the coordinates X1, Y1 of the first
# point, then repeatedly the interior angle theta and the distance l;
# output the azimuth alpha(n) = theta + alpha(n-1) + 180 (- 360) and the
# coordinates X(n+1) = X(n) + l cos alpha, Y(n+1) = Y(n) + l sin alpha
# of the next point. Angles d.mmss, P4 subtracts 360, P8 rounds to
# three decimals, P9 converts d.mmss to degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 98
# @calculator 502
# @number 404

*** P0
DEG 3 6 0 MinF AC                                           # 6
HLT GSBP9 Min1 DMS<-                                        # 10
HLT Min2 0                                                  # 13
HLT Min3 0                                                  # 16
LBL1 HLT GSBP9 Min4 DMS<- HLT                               # 22
Min5 MR4 + MR1 + 1 8 0 =                                    # 31
x>=F GSBP4 x>=F GSBP4                                       # 35
Min1 DMS<- HLT                                              # 38
MR2 + MR5 * MR1 cos = GSBP8 Min2 HLT                        # 48
MR3 + MR5 * MR1 sin = GSBP8 Min3 GOTO1                      # 58

*** P4
- MRF =                                                     # 3

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22
