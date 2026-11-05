# BANK06 - Calculation for discounting commercial bills (by annual interest
# basis)
# Banking-6, description see Program Library FX-601P/FX-602P, page 155 - 156
# prg code converted from the original document by Claude Code
#
# P0 input of the bills, P1 sums.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 72
# @calculator 602
# @name "BANK06"
# @mode .20

*** P0
MAC                                                         # 1
ISZ "a1"                                                    # 6
LBL1 HLT Min01 M+02 "b\AR00" HLT                            # 15
Min03 "c\AR00" HLT * MR01                                   # 23
* MR03 / 3 6 5 0 0 = INT M+04                               # 34
"d\AR00=#" ISZ                                              # 41
GOTO1                                                       # 42

*** P1
DSZ MR02 "\SMa\AR00=#" HLT - MR04 "\SMd\AR00=#"             # 7, 15, 19
HLT - MR04 = "f=#"                                          # 24, 28
