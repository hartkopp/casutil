# SURV34 - Corner cut-off
# Surveying-34, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-34
# prg code converted from the original document by Claude Code
#
# Input the corner angle theta (d.mmss) and the length L of the cut-off
# line; output the equal sides l = L / 2 cosec(theta / 2) (rounded to
# three decimals) and the cut-off area S = (L / 2)^2 cot(theta / 2)
# (rounded to four decimals, MF = 4 after 1 M+F). P8 rounds to MF
# decimals, P9 converts d.mmss to degrees. Start again with P0.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 68
# @calculator 502
# @number 434

*** P0
DEG 3 MinF AC                                               # 4
HLT GSBP9 / 2 = Min1 0 HLT / 2 = Min2                       # 16
/ MR1 sin = GSBP8 HLT 1 M+F                                 # 24
MR2 x^2 / MR1 tan = GSBP8 HLT                               # 32

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22

*** P8
* MRF 10^x + FRAC = INT / MRF 10^x =                        # 11
