# SURV25 - Intersection 3 (two points and two azimuths known)
# Surveying-25, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-25
# prg code converted from the original document by Claude Code
#
# Input the point A (X1, Y1) with the azimuth alpha and the point B
# (X2, Y2) with the azimuth beta (d.mmss) repeatedly; output the
# intersection P (X, Y) of both lines, rounded to three decimals by P8.
# P9 converts d.mmss to degrees and calculates tan.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 91
# @calculator 502
# @number 425

*** P0
DEG AC                                                      # 2
LBL1 HLT Min1 0 HLT Min2 0 HLT GSBP9 Min3 0 HLT Min4        # 15
0 HLT Min5 0 HLT GSBP9 Min6                                 # 22
* MR4 - MR3 * MR1 + MR2 - MR5 = / (                         # 35
MR6 - MR3 ) = Min7 GSBP8 HLT MR7 - MR1                      # 46
= * MR3 + MR2 = GSBP8 GOTO1                                 # 54

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 = tan                            # 23

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
