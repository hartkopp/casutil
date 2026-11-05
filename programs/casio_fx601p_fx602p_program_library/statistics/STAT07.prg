# STAT07 - Quadratic regression analysis
# Statistics-7, description see Program Library FX-601P/FX-602P, page 109 - 110
# prg code converted from the original document by Claude Code
#
# P0 data input, P1 coefficients a, b, c and estimates y.
# The comment behind a line is the step number of the program sheet.
# Total 140
# @calculator 602
# @name "STAT07"
# @mode .20

*** P0
MAC                                                         # 1
LBL1 ISZ MR00 "x#" HLT xD                                   # 10
* * = = M+06 = M+05                                         # 17
MR00 "y#" HLT M+04 =                                        # 25
M+03 = M+02 AC GOTO1                                        # 30

*** P1
xbar * * MR04 = M-03                                        # 6
MR07 = M-06                                                 # 9
MR07 / MR09 * * MR04 = M-02                                 # 17
MR07 = M-05                                                 # 20
MR07 - xbar * MR08 = Min00 * MR05 -                         # 30
MR06 x^2 = / / ( MR02 * MR00 -                              # 40
MR03 * MR06 ) = Min01 "a=#"                                 # 49, 51
HLT                                                         # 52
( MR03 * MR05 - MR02 * MR06 ) =                             # 62
Min00 "b=#" HLT                                             # 69
MR04 / MR09 - MR00 * xbar - MR01 *                          # 79
MR07 / MR09 = MinF "c=#"                                    # 88, 89
LBL1 HLT Min09 x^2 * MR01 + MR09 * MR00 +                   # 100
MRF = "y=#" GOTO1                                           # 108
