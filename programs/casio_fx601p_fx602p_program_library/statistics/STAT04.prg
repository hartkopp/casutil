# STAT04 - Correlation coefficient
# Statistics-4, description see Program Library FX-601P/FX-602P, page 103 - 104
# prg code converted from the original document by Claude Code
#
# P0 data input, P1 result. The registers are M08 (sum x), M07
# (sum x^2), M09 (n), M06 (sum y), M05 (sum y^2) and M04 (sum xy).
# The comment behind a line is the step number of the program sheet.
# Total 70
# @calculator 602
# @name "STAT04"
# @mode .20

*** P0
MAC                                                         # 1
LBL1 ISZ MR00 "x#" HLT xD                                   # 10
* MR00 "y#" HLT                                             # 17
M+06 Min03 = M+04 MR03 x^2 M+05 GOTO1                       # 25

*** P1
MR09 * MR04 - MR08 * MR06 = / ( (                           # 11
MR09 * MR07 - MR08 x^2 ) * ( MR09                           # 21
* MR05 - MR06 x^2 ) ) SQR =                                 # 30
"r=#" HLT                                                   # 36
x^2 "r2=#"                                                  # 43
