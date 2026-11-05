# MATH15 - Bessel function of the first kind and n-th order
# Mathematics-15, description see Program Library FX-601P/FX-602P, page 31 - 32
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# 85 steps, the sheet gives no total
# @calculator 602
# @name "MATH15"
# @mode .20

*** P0
LBL1 MAC "x?" HLT Min07 / 2                                 # 10
= Min01 x^2 Min03 0                                         # 15
"n?" HLT Min02 Min06 x!                                     # 23
Min09 1/x Min00                                             # 26
LBL2 1 M+04 M+05 M+06                                       # 31
MR09 * MR06 * MR05 = Min09                                  # 38
MR04 / 2 = FRAC x=0 GOTO3                                   # 45
GOTO4                                                       # 46
LBL3 GSBP1 M+00 GOTO5                                       # 50
LBL4 GSBP1 M-00                                             # 53
LBL5 MR00 x=F GOTO6                                         # 57
MinF GOTO2                                                  # 59
LBL6 MR01 x^y MR02 * MR00 =                                 # 66
"J\AR02(\AR07)=#" HLT GOTO1                                 # 73, 77

*** P1
MR03 x^y MR04 / MR09 =                                      # 6
