# STAT13 - F-test
# Statistics-13, description see Program Library FX-601P/FX-602P, page 121 - 122
# prg code converted from the original document by Claude Code
#
# P0 input of the data x, P1 of the data y, P2 result.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 63
# @calculator 602
# @name "STAT13"
# @mode .20

*** P0
MAC                                                         # 1
LBL1 ISZ MR00 "x#" HLT xD                                   # 10
GOTO1                                                       # 11

*** P1
MR00 Min01 sdn-1 x^2 Min02 SAC 0 Min00                      # 8
LBL1 ISZ MR00 "y#" HLT xD                                   # 17
GOTO1                                                       # 18

*** P2
2 M-01 MR01 "p1=#" HLT 2 M-00 MR00 "p2=#" HLT               # 9, 18, 20
MR02 / sdn-1 x^2 = "F0=#"                                   # 29, 31
