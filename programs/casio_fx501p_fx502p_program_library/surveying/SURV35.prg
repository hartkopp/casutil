# SURV35 - Division of a trapezoid area
# Surveying-35, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-35
# prg code converted from the original document by Claude Code
#
# Input the parallel sides l1 > l2 and the width d; the area of the
# trapezoid is shown. Then repeatedly input the area S1 of the next part;
# output its width x and the height y of its dividing line (rounded to
# three decimals by P8), and the remaining area.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 88
# @calculator 502
# @number 435

*** P0
AC HLT Min1 0 HLT Min2 0 HLT Min3                           # 9
LBL1 MR1 - MR2 = Min5                                       # 15
MR2 x^2 * MR3 / 2 / MR5 = Min7                              # 25
MR1 x^2 * MR3 / 2 / MR5 = Min6 - MR7                        # 37
= HLT Min4                                                  # 40
MR6 - MR4 = / MR7 = SQR * MR2 = Min8                        # 52
MR1 - MR8 = * MR3 / MR5 = Min6 GSBP8                        # 63
HLT                                                         # 64
MR8 Min1 MR3 - MR6 = Min3 MR8 GSBP8 HLT                     # 74
GOTO1                                                       # 75

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
