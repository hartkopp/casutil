# SURV22 - Perpendicular and distance 2 (two points and one azimuth
#          known)
# Surveying-22, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-22
# prg code converted from the original document by Claude Code
#
# Like SURV21, but the line is given by the point A and its azimuth
# alpha (d.mmss): input XA, YA, alpha, then repeatedly a point C; output
# the foot P of the perpendicular from C and the distance l = CP,
# rounded to three decimals by P8. P9 converts d.mmss to degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 111
# @calculator 502
# @number 422

*** P0
DEG AC HLT Min1 0                                           # 5
HLT Min2 0                                                  # 8
HLT GSBP9 Min3 tan Min7 MR3 DMS<-                           # 15
LBL1 HLT Min5 0                                             # 19
HLT Min6                                                    # 21
MR7 * MR1 + MR7 1/x * MR5 - MR2 +                           # 32
MR6 = / ( MR7 + MR7 1/x ) = GSBP8                           # 43
Min3 HLT                                                    # 45
MR2 + MR7 * ( MR3 - MR1 ) = GSBP8                           # 56
Min4 HLT                                                    # 58
( MR5 - MR3 ) x^2 + ( MR6 - MR4 )                           # 70
x^2 = SQR GSBP8 GOTO1                                       # 75

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22
