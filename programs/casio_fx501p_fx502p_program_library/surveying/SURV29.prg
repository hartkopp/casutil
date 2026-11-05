# SURV29 - Area and arc of a circular segment from chord and radius
# Surveying-29, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-29
# prg code converted from the original document by Claude Code
#
# Input the chord l and the radius R repeatedly; output the central
# angle IA = 2 sin-1(l / 2R) (d.ms), the area of the segment
# S = pi R^2 IA / 360 - R^2 sin(IA) / 2 (rounded to four decimals) and
# the arc CL = pi / 180 R IA (rounded to three decimals). P8 rounds to
# MF decimals.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 72
# @calculator 502
# @number 429

*** P0
AC DEG                                                      # 2
LBL1 HLT / 2 = Min1 0 HLT Min2 4 MinF                       # 13
MR1 / MR2 = sin-1 * 2 = Min4 DMS<- HLT                      # 24
MR2 x^2 * PI * MR4 / 3 6 0 - MR2 x^2                        # 37
/ 2 * MR4 sin = GSBP8                                       # 44
HLT 1 M-F                                                   # 47
PI / 1 8 0 * MR2 * MR4 = GSBP8                              # 58
GOTO1                                                       # 59

*** P8
* MRF 10^x + FRAC = INT / MRF 10^x =                        # 11
