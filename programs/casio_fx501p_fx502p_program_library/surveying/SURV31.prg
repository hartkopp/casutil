# SURV31 - Corner point of a street corner 1 (0 < theta < 90)
# Surveying-31, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-31
# prg code converted from the original document by Claude Code
#
# Input the coordinates X0, Y0 of the vertex O, the azimuth alpha0, the
# street widths W1, W2 and the crossing angle theta (angles d.mmss);
# output the angle alpha1, the azimuth alpha3 = alpha0 + alpha1 (d.ms),
# the distance R = OP and the coordinates XP, YP of the corner point
# P, rounded to three decimals by P8. P9 converts d.mmss to degrees.
# Start again with P0.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 94
# @calculator 502
# @number 431

*** P0
DEG MAC AC HLT                                              # 4
X<->M1 HLT X<->M2 HLT GSBP9 Min3 DMS<- HLT                  # 12
X<->M4 HLT X<->M5 HLT GSBP9 Min6                            # 18
MR4 / ( MR5 / MR6 sin + MR4 / MR6 tan ) =                   # 32
tan-1 Min7 M+3 DMS<- HLT                                    # 37
MR3 DMS<- HLT                                               # 40
MR4 / MR7 sin = GSBP8 HLT                                   # 47
P->R MR3 = M+1 X<->Y M+2                                    # 53
MR1 GSBP8 HLT MR2 GSBP8                                     # 58

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
