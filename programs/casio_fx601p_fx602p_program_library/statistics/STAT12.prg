# STAT12 - t-distribution
# Statistics-12, description see Program Library FX-601P/FX-602P, page 119 - 120
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 125
# @calculator 602
# @name "STAT12"
# @mode .20

*** P0
RAD MAC "x" HLT Min01                                       # 7
"v" HLT Min02                                               # 12
1 MinF Min09 Min00                                          # 16
MR01 / MR02 SQR = tan-1 Min01 cos x^2                       # 25
Min06 MR02 / 2 = FRAC x=0 GOTO2                             # 33
2 * MR01 / PI = Min03 MR02 x=F                              # 42
GOTO6                                                       # 43
MR02 - 1 = MinF 3 Min07                                     # 50
LBL8 2 M+08 MR08 x=F GOTO9                                  # 56
MR09 * MR08 / MR07 * MR06 = Min09                           # 65
M+00 2 M+07 GOTO8                                           # 69
LBL2 MR02 MinF 1 Min07                                      # 74
LBL3 2 M+08 MR08 x=F GOTO4                                  # 80
MR09 * MR07 / MR08 * MR06 = Min09                           # 89
M+00 2 M+07 GOTO3                                           # 93
LBL4 MR01 sin * MR00 = GOTO0                                # 100
LBL6 MR03 GOTO0                                             # 103
LBL9 2 / PI * MR01 cos * MR01 sin * MR00                    # 115
+ MR03 =                                                    # 118
LBL0 "I=#"                                                  # 124
