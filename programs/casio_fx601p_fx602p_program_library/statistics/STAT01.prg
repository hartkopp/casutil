# STAT01 - Geometrical and harmonic means
# Statistics-1, description see Program Library FX-601P/FX-602P, page 97 - 98
# prg code converted from the original document by Claude Code
#
# P1 geometrical mean, P2 harmonic mean.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 65
# @calculator 602
# @name "STAT01"
# @mode .20

*** P1
MAC 1 Min00 Min01                                           # 4
LBL3 "\*(\AR00)" HLT *                                      # 13
MR01 = Min01 ISZ GOTO3                                      # 18
LBL1 MR01 x^(1/y) ( MR00 - 1 ) = "Gm=#"                     # 29, 33

*** P2
MAC 1 Min00                                                 # 3
LBL3 "\*(\AR00)" HLT 1/x                                    # 12
M+01 ISZ GOTO3                                              # 15
LBL1 ( MR00 - 1 ) / MR01 = "Hm=#"                           # 27, 30
