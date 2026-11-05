# SURV09 - Triangle 2 (area from two sides and the included angle)
# Surveying-9, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-9
# prg code converted from the original document by Claude Code
#
# Input a, b and the included angle theta (d.mmss) repeatedly; output
# the area S = ab sin(theta) / 2, rounded to four decimals by P8. P9
# converts d.mmss to degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 59
# @calculator 502
# @number 409

*** P0
DEG AC                                                      # 2
LBL1 HLT Min1 0                                             # 6
HLT Min2 0                                                  # 9
HLT GSBP9 Min3                                              # 12
MR1 * MR2 * MR3 sin / 2 = GSBP8 GOTO1                       # 23

*** P8
* 4 10^x + FRAC = INT / 4 10^x =                            # 11

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22
