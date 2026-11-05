# SURV33 - Area by offsets (trapezoidal rule)
# Surveying-33, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-33
# prg code converted from the original document by Claude Code
#
# Input the first offset H0, then repeatedly the distance L and the next
# offset H; each trapezoid area S = (H(i-1) + H) / 2 * L is shown,
# rounded to four decimals by P8, and added to M8 (L = 0 for a step in
# the offsets). P1 shows the total area.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 41
# @calculator 502
# @number 433

*** P0
AC Min8                                                     # 2
HLT Min3 0                                                  # 5
LBL1 HLT Min2 MR3 Min1 0 HLT Min3                           # 13
+ MR1 = * MR2 / 2 = x=0 GOTO1                               # 23
GSBP8 M+8 GOTO1                                             # 26

*** P8
* 4 10^x + FRAC = INT / 4 10^x =                            # 11

*** P1
MR8                                                         # 1
