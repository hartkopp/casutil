# SURV24 - Intersection 2 (three points and one azimuth known)
# Surveying-24, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-24
# prg code converted from the original document by Claude Code
#
# Input the points A (X1, Y1) and B (X2, Y2) of the first line, the
# point C (X3, Y3) and the azimuth alpha (d.mmss) of the second line
# repeatedly; output the intersection P (X, Y), rounded to three
# decimals by P8. P9 converts d.mmss to degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 102
# @calculator 502
# @number 424

*** P0
DEG AC                                                      # 2
LBL1 HLT Min1 0 HLT Min2 0 HLT - MR1 = Min3 0 HLT -         # 17
MR2 = / MR3 = Min4 0 HLT Min5 0 HLT Min6                    # 29
0 HLT GSBP9 tan Min7                                        # 34
* MR5 - MR4 * MR1 + MR2 - MR6 = /                           # 46
( MR7 - MR4 ) = Min8 GSBP8 HLT MR8 -                        # 57
MR1 = * MR4 + MR2 = GSBP8 GOTO1                             # 66

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
