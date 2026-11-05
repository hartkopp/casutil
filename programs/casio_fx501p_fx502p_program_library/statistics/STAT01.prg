# STAT01 - Deviation value
# Statistics-1, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-1
# prg code converted from the original document by Claude Code
#
# D = 50 + 10 (x - mean) / sdn, rounded to an integer.
# P1 enter all scores, then P0 shows mean and sdn and calculates D for
# each score entered; P2 enter mean and sdn, then the scores.
# FX-501P/FX-502P only, not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 49
# @calculator 502
# @number 301

*** P1
SAC 1 Min0                                                  # 3
LBL1 HLT xD ISZ MR0                                         # 8
GOTO1                                                       # 9

*** P2
0 HLT Min1 0 HLT Min2 0 HLT GSBP3                           # 9

*** P0
xbar Min1 HLT sdn Min2 HLT GSBP3                            # 7

*** P3
LBL1 - MR1 = * 1 0 / MR2 + 5 0 = + . 5 =                    # 17
INT HLT GOTO1                                               # 20
