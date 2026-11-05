# SURV20 - Coordinates of an intermediate point
# Surveying-20, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-20
# prg code converted from the original document by Claude Code
#
# Input the coordinates of A and B and the distance l from A repeatedly;
# output the azimuth alpha from A to B (d.ms, 0 <= alpha < 360) and the
# coordinates XP = l cos alpha + XA, YP = l sin alpha + YA of the point
# P on AB, rounded to three decimals by P8.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 67
# @calculator 502
# @number 420

*** P0
DEG AC                                                      # 2
LBL1 HLT Min1 0                                             # 6
HLT Min2 0                                                  # 9
HLT Min3 0                                                  # 12
HLT Min4 0                                                  # 15
HLT Min5 ( MR3 - MR1 ) R->P ( MR4 -                         # 26
MR2 ) = X<->Y x>=0 GOTO2                                    # 32
+ 3 6 0 =                                                   # 37
LBL2 Min6 DMS<- HLT                                         # 41
MR5 P->R MR6 = M+1 X<->Y M+2                                # 48
MR1 GSBP8 HLT                                               # 51
MR2 GSBP8 GOTO1                                             # 54

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
