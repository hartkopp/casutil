# SURV12 - Solution of a triangle 2 (two sides and the included angle
#          known)
# Surveying-12, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-12
# prg code converted from the original document by Claude Code
#
# Input a, b and the included angle gamma (d.mmss); output the area S
# (rounded to four decimals), the third side c (rounded to three
# decimals by MF = 3 in line 7), and the angles alpha and beta (d.ms).
# P8 rounds to MF decimals. Start again with P0 for the next triangle.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 104
# @calculator 502
# @number 412

*** P0
DEG                                                         # 1
4 MinF AC                                                   # 4
HLT Min1 0 HLT Min2 0                                       # 10
HLT Min6 INT + ( MR6 FRAC * 2 10^x ) Min6                   # 22
INT / 6 0 + MR6 FRAC / 3 6 = Min6                           # 34
sin * MR1 * MR2 / 2 = Min0 GSBP8 HLT                        # 45
1 M-F ( MR1 x^2 + MR2 x^2 - MR6 cos                         # 56
* MR1 * MR2 * 2 ) SQR Min3 GSBP8 HLT                        # 67
( MR0 * 2 / MR2 / MR3 ) sin-1 Min4 DMS<-                    # 79
HLT                                                         # 80
1 8 0 - MR4 - MR6 = Min5 DMS<- HLT                          # 91

*** P8
* MRF 10^x + FRAC = INT / MRF 10^x =                        # 11
