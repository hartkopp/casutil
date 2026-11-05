# SURV02 - Coordinates from azimuth and distance
# Surveying-2, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-2
# prg code converted from the original document by Claude Code
#
# Input XA, YA, the azimuth alpha (d.mmss) and the distance l repeatedly;
# output XP = l cos alpha + XA and YP = l sin alpha + YA, rounded to
# three decimals by P8. P9 converts d.mmss to degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 67
# @calculator 502
# @number 402

*** P0
DEG                                                         # 1
LBL1 HLT Min1 AC                                            # 5
HLT Min2 0                                                  # 8
HLT GSBP9 Min3 DMS<- HLT                                    # 13
Min4 * MR3 cos + MR1 = GSBP8 HLT                            # 22
MR4 * MR3 sin + MR2 = GSBP8 GOTO1                           # 31

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22
