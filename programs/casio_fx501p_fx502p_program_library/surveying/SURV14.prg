# SURV14 - Area by three sides (triangulated area)
# Surveying-14, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-14
# prg code converted from the original document by Claude Code
#
# Input the three sides ab, bc and ca of each triangle; output the area
# by Heron's formula (rounded to four decimals), the longest side as
# base, the height (rounded to two decimals) and the double area base *
# height. After the last triangle P1 shows the total of the double
# areas, half of it, and the total of the Heron areas.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 94
# @calculator 502
# @number 414

*** P0
MAC AC                                                      # 2
LBL1 HLT Min1 0                                             # 6
HLT Min2 0                                                  # 9
HLT Min3 + MR1 + MR2 = / 2 = Min4                           # 20
4 MinF                                                      # 22
MR4 * ( MR4 - MR1 ) * ( MR4 - MR2 )                         # 35
* ( MR4 - MR3 ) = SQR GSBP8 Min5 M+6 HLT                    # 47
MR1 MinF MR2 x>=F MinF                                      # 52
MR3 x>=F MinF MRF Min7 HLT                                  # 58
2 MinF * MR5 / MR7 = GSBP8 Min4 HLT                         # 68
* MR7 = M+8 GOTO1                                           # 73

*** P1
MR8 HLT / 2 = HLT MR6                                       # 7

*** P8
* MRF 10^x + FRAC = INT / MRF 10^x =                        # 11
