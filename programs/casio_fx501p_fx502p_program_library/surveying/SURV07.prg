# SURV07 - Inverse calculation (continuous)
# Surveying-7, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-7
# prg code converted from the original document by Claude Code
#
# Input the coordinates X, Y of the points one after the other; for
# each line output the azimuth alpha (d.ms, 0 <= alpha < 360), from the
# second line on the interior angle theta = alpha(n) - alpha(n-1) + 180
# (d.ms, 0 < theta < 360), and the distance l, rounded to three
# decimals by P8. P5 subtracts 360.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 80 (the sheet says 79, the step numbers of the lines add up
# to 80)
# @calculator 502
# @number 407

*** P0
DEG MAC 3 6 0 MinF AC                                       # 7
HLT Min1 0                                                  # 10
HLT Min2 0                                                  # 13
LBL1 HLT Min3 0                                             # 17
HLT Min4 ( MR3 - X<->M1 ) R->P ( MR4 -                      # 28
X<->M2 ) = Min5                                             # 32
X<->Y x>=0 GOTO2 + MRF =                                    # 38
LBL2 Min6 DMS<- HLT                                         # 42
MR7 x=0 GOTO3 +/- + MR6 + 1 8 0 =                           # 53
x>=F GSBP5 DMS<- HLT                                        # 57
LBL3 MR6 Min7 MR5 GSBP8 GOTO1                               # 63

*** P5
- MRF =                                                     # 3

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
