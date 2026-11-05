# SURV19 - Stadia calculation
# Surveying-19, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-19
# prg code converted from the original document by Claude Code
#
# Input the stadia constants K and C, then repeatedly the staff reading
# l and the vertical angle alpha (d.mmss); output the horizontal
# distance S = K l cos^2 alpha + C cos alpha and the difference in
# height h = K l sin(2 alpha) / 2 + C sin alpha, rounded to three
# decimals by P8. P9 converts d.mmss to degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 87
# @calculator 502
# @number 419

*** P0
DEG AC                                                      # 2
HLT Min1 0                                                  # 5
HLT Min2 0                                                  # 8
LBL1 HLT Min3 0                                             # 12
HLT GSBP9 Min4                                              # 15
MR1 * MR3 * MR4 cos x^2 + MR2 * MR4                         # 26
cos = GSBP8 HLT                                             # 30
2 1/x * MR1 * MR3 * ( 2 * MR4 )                             # 42
sin + MR2 * MR4 sin = GSBP8 GOTO1                           # 51

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22
