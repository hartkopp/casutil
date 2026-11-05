# STAT11 - F-distribution
# Statistics-11, description see Program Library FX-601P/FX-602P, page 117 - 118
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 183
# @calculator 602
# @name "STAT11"
# @mode .20

*** P0
MAC "x" HLT Min01 "v1" HLT Min02 "v2" HLT                   # 8, 17
Min03 / ( MR03 + MR01 * MR02 ) =                            # 27
Min06 1 Min00 Min09 MinF                                    # 32
MR03 / 2 = Min05 MR02 / 2 = FRAC                            # 42
x=0 GOTO1                                                   # 44
MR05 FRAC x=0 GOTO5                                         # 48
0 GOTO9                                                     # 50
LBL1 MR05 FRAC x=0 GOTO2                                    # 55
GOTO4                                                       # 56
LBL2 MR02 - MR03 = x>=0 GOTO5                               # 63
LBL4 0 Min01 Min05 MR03 Min04 1 - MR06 =                    # 73
Min07 ( MR02 - 2 ) / 2 = x=F GOTO7                          # 84
MinF GOTO6                                                  # 86
LBL5 1 Min01 0 Min05 MR02 Min04 MR06 Min07                  # 95
( MR03 - 2 ) / 2 = x=F GOTO7 MinF                           # 106
LBL6 1 M+08 MR08 x=F GOTO7                                  # 112
2 M+05 MR09 * MR04 / MR05 * MR07 =                          # 122
Min09 M+00 2 M+04 GOTO6                                     # 127
LBL7 MR09 * MR04 / ( MR05 + 2 ) * MR07                      # 139
= M+00 MR01 x=0 GOTO8                                       # 144
1 - MR06 = Min07 1 - MR00 * MR07                            # 154
x^y ( MR02 / 2 ) = GOTO9                                    # 162
LBL8 MR00 * MR06 x^y ( MR03 / 2 ) =                         # 173
LBL9 "Q(x)=#"                                               # 182
