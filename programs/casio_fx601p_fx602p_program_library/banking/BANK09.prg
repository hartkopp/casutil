# BANK09 - Horizontal/vertical aggregate calculations
# Banking-9, description see Program Library FX-601P/FX-602P, page 161 - 162
# prg code converted from the original document by Claude Code
#
# P0 input of the rows y and columns x, P1 column totals.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 74 (FX-602P only)
# @calculator 602
# @name "BANK09"
# @mode .74

*** P0
MAC MinF GOTO2                                              # 3
LBL1 "y\AR1F-x\AR2F?" HLT IND M+00 M+3F 1 M+2F              # 12, 21
DSZ GOTO1                                                   # 23
"y\AR1F=\AR3F" HLT                                          # 31
LBL2 1 M+1F Min2F 0 Min3F MRF Min00 GOTO1                   # 42

*** P1
MRF Min00 0 Min1F Min2F                                     # 6
LBL1 1 M+1F IND MR00 M+2F                                   # 13
"x\AR1F=#" HLT                                              # 20
DSZ GOTO1                                                   # 22
MR2F "\SMx=#"                                               # 30
