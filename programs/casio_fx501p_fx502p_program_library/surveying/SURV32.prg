# SURV32 - Corner point of a street corner 2 (90 < theta < 180)
# Surveying-32, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-32
# prg code converted from the original document by Claude Code
#
# Like SURV31 for a crossing angle theta between 90 and 180 degrees:
# input X0, Y0, the azimuth alpha0, the street widths W1, W2 and theta
# (angles d.mmss); output alpha1, alpha3 (d.ms), R = OP and the
# coordinates XP, YP of the corner point P, rounded to three decimals
# by P8. P9 converts d.mmss to degrees. Start again with P0.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 98
# @calculator 502
# @number 432

*** P0
DEG MAC AC HLT                                              # 4
X<->M1 HLT X<->M2 HLT GSBP9 Min3 DMS<- HLT                  # 12
X<->M4 HLT X<->M5 HLT GSBP9 - 9 0 = Min6                    # 22
MR4 / ( MR5 / MR6 cos - MR4 * MR6 tan ) =                   # 36
tan-1 Min7 M+3 DMS<- HLT                                    # 41
MR3 DMS<- HLT                                               # 44
MR4 / MR7 sin = GSBP8 HLT                                   # 51
P->R MR3 = M+1 X<->Y M+2                                    # 57
MR1 GSBP8 HLT MR2 GSBP8                                     # 62

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
