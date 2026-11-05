# SURV13 - Solution of a triangle 3 (one side and the two adjacent
#          angles known)
# Surveying-13, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-13
# prg code converted from the original document by Claude Code
#
# Input a and the adjacent angles beta and gamma (d.mmss); output the
# third angle alpha (d.ms), the sides b and c by the law of sines
# (rounded to three decimals) and the area S (rounded to four decimals,
# MF = 4 after 1 M+F). P1 calculates a side, P8 rounds to MF decimals,
# P9 converts d.mmss to degrees. Start again with P0.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 94
# @calculator 502
# @number 413

*** P0
DEG                                                         # 1
3 MinF AC                                                   # 4
HLT Min1 0                                                  # 7
HLT GSBP9 Min5 0 HLT GSBP9 Min6                             # 14
+/- - MR5 + 1 8 0 = Min4 DMS<- HLT                          # 25
GSBP1 Min2 GSBP8 HLT                                        # 29
MR6 X<->M5 Min6 GSBP1 Min3 GSBP8 HLT 1 M+F                  # 38
MR3 * MR1 * MR6 sin / 2 = GSBP8 HLT                         # 49

*** P1
MR1 * MR5 sin / MR4 sin =                                   # 8

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22

*** P8
* MRF 10^x + FRAC = INT / MRF 10^x =                        # 11
