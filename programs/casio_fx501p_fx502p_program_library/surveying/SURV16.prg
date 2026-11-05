# SURV16 - Area from angles and distances
# Surveying-16, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-16
# prg code converted from the original document by Claude Code
#
# Input the angle theta (d.mmss) and the distance l of each corner, seen
# from a base point; output dx = l cos theta and dy = l sin theta
# (rounded to two decimals by P8). After the last corner P1 gives the
# area S = |sum (dx1 - dxi)(dy(i+1) - dy(i-1))| / 2. P3 is the input,
# P4 adds one term, P9 converts d.mmss to degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 101
# @calculator 502
# @number 416

*** P0
DEG MAC AC                                                  # 3
GSBP3 MR6 Min1 MR7 Min2 Min3                                # 9
GSBP3 MR6 Min4 MR7 Min5                                     # 14
LBL1 GSBP3                                                  # 16
GSBP4                                                       # 17
MR5 Min3 MR6 Min4 MR7 Min5 GOTO1                            # 24

*** P1
MR2 Min7 GSBP4 MR8 ABS / 2 = HLT                            # 9

*** P4
( MR1 - MR4 ) * ( MR7 - MR3 ) = M+8                         # 13

*** P3
HLT GSBP9 MinF DMS<- HLT                                    # 5
P->R MRF = Min7 X<->Y GSBP8                                 # 11
X<->M7 GSBP8 Min6 HLT MR7                                   # 16

*** P8
* 2 10^x + FRAC = INT / 2 10^x =                            # 11

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22
