# SURV10 - Triangle 3 (area and heights from three sides)
# Surveying-10, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-10
# prg code converted from the original document by Claude Code
#
# Input a, b and c repeatedly; output the area S by Heron's formula
# (rounded to four decimals) and the heights hc, hb, ha = 2S / side
# (rounded to three decimals). P8 rounds to MF decimals.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 74
# @calculator 502
# @number 410

*** P0
AC HLT                                                      # 2
LBL1 Min1 0                                                 # 5
HLT Min2 0                                                  # 8
HLT Min3 + MR1 + MR2 = / 2 = Min4                           # 19
4 MinF                                                      # 21
MR4 * ( MR4 - MR1 ) * ( MR4 - MR2                           # 33
) * ( MR4 - MR3 ) = SQR GSBP8 Min5                          # 44
HLT 3 MinF Min0                                             # 48
LBL2 2 * MR5 / IND MR0 = GSBP8 HLT                          # 58
DSZ GOTO2 GOTO1                                             # 61

*** P8
* MRF 10^x + FRAC = INT / MRF 10^x =                        # 11
