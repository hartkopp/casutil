# MECH02 - Cantilever under distributed load
# Mechanics-2, description see Program Library FX-601P/FX-602P, page 69 - 70
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 128
# @calculator 602
# @name "MECH02"
# @mode .20

*** P0
HLT Min01 HLT Min02 HLT Min03 MinF HLT Min04                # 9
/ 6 / MR01 / MR02 = +/- Min06 0 DEG                         # 20
LBL1 HLT Min05 x>=F GOTO2 GOTO3                             # 26
LBL2 MR06 * MR03 x^y 3 = Min07 * ( MR05                     # 37
- MR03 / 4 ) = HLT                                          # 44
MR07 tan-1 HLT                                              # 47
0 HLT 0 GOTO1                                               # 51
LBL3 MR05 x^2 Min08 MR03 * MR05 = Min09                     # 60
MR03 x^2 Min00 MR06 * MR05 = Min07                          # 68
* MR05 * ( MR08 / 4 - MR09 + 3 *                            # 80
MR00 / 2 ) = HLT                                            # 86
MR07 * ( MR08 - 3 * MR09 + 3 *                              # 97
MR00 ) = tan-1 HLT                                          # 102
MR04 +/- * ( MR08 / 2 - MR09 + MR00                         # 113
/ 2 ) = HLT MR04 * ( MR03 - MR05 )                          # 125
= GOTO1                                                     # 127
