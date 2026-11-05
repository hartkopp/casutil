# STAT05 - Spearman's coefficient of rank correlation
# Statistics-5, description see Program Library FX-601P/FX-602P, page 105 - 106
# prg code converted from the original document by Claude Code
#
# P0 input of the ranks, P1 result.
# The comment behind a line is the step number of the program sheet.
# Total 42
# @calculator 602
# @name "STAT05"
# @mode .20

*** P0
MAC                                                         # 1
LBL1 ISZ MR00 "A#" HLT -                                    # 10
MR00 "B#" HLT = x^2                                         # 18
M+01 GOTO1                                                  # 20

*** P1
DSZ 1 - 6 * MR01 / ( MR00 x^y 3                             # 11
- MR00 ) = "r=#"                                            # 20
