# STAT03 - n-month moving average (n < 77)
# Statistics-3, description see Program Library FX-601P/FX-602P, page 101 - 102
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 48
# @calculator 602
# @name "STAT03"
# @mode .25

*** P0
MAC "n=?" HLT Min00                                         # 8
Min1F                                                       # 9
LBL1 MR1F - MR00 + 1 = "y#" HLT IND Min00 M+F DSZ GOTO1     # 19, 26
LBL2 MR1F Min00                                             # 29
LBL3 MRF / MR1F = "Y=#" HLT                                 # 40
M+F IND X<->M00 M-F DSZ GOTO3 GOTO2                         # 47
