# SURV08 - Triangle 1 (third side from two sides and the included angle)
# Surveying-8, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-8
# prg code converted from the original document by Claude Code
#
# Input a, b and the included angle theta (d.mmss) repeatedly; output
# c = sqrt(a^2 + b^2 - 2ab cos theta), rounded to three decimals by P8.
# P9 converts d.mmss to degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 66
# @calculator 502
# @number 408

*** P0
DEG AC                                                      # 2
LBL1 HLT Min1 0                                             # 6
HLT Min2 0                                                  # 9
HLT GSBP9 Min3                                              # 12
MR1 x^2 + MR2 x^2 - 2 * MR1 * MR2                           # 23
* MR3 cos = SQR GSBP8 GOTO1                                 # 30

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22
