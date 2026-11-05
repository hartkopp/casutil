# STAT17 - Analysis of variance with one-way layout
# Statistics-17, description see Program Library FX-601P/FX-602P, page 129 - 130
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 157
# @calculator 602
# @name "STAT17"
# @mode .20

*** P0
MAC                                                         # 1
"m" HLT Min01 Min08                                         # 7
"n" HLT Min02 Min09 2 Min00                                 # 15
LBL2 "x" HLT x=0 GOTO6                                      # 22
M+03 x^2 M+04                                               # 25
LBL3 IND DSZ GOTO2                                          # 29
DSZ IND DSZ GOTO4                                           # 33
GSBP1 MR08 * MR09 - MR07 = Min07                            # 41
MR05 x^2 / MR07 = Min01                                     # 47
MR04 - MR01 = Min02 "ST=#" HLT                              # 57, 59
MR06 - MR01 = Min03 "SP=#" HLT                              # 69, 71
MR02 - MR03 = Min04 "SE=#" HLT                              # 81, 83
MR03 / ( MR08 - 1 ) = Min05 "MST=#" HLT                     # 93, 100
MR04 / ( MR07 - MR08 ) = Min06 "MSE=#" HLT                  # 110, 117
MR05 / MR06 = "F=#" HLT                                     # 127
LBL4 GSBP1 2 Min00 MR09 Min02 0 Min03 MinF                  # 136
GOTO2                                                       # 137
LBL6 1 M+F 0 GOTO3                                          # 142

*** P1
MR03 M+05 x^2 / ( MR09 - MRF ) =                            # 10
M+06 MRF M+07                                               # 13
