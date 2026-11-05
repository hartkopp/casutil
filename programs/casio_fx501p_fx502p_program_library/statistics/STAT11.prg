# STAT11 - Chi-square distribution
# Statistics-11, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-11
# prg code converted from the original document by Claude Code
#
# Input x and the degrees of freedom v; output f(x) and P(x).
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT10,
# with prompts and alpha output, same formulas, but without loop and
# with the odd v part (MR04 Min03 GOTO5) directly behind x=0 GOTO2.
# The comment behind a line is the step number of the program sheet.
# Total 120
# @calculator 502
# @number 311

*** P0
LBL1 MAC HLT Min1 0 HLT Min2 Min8 . 5 MinF                  # 11
MR2 / 2 = Min3 - 1 = Min4 MR1 / 2 =                         # 24
Min5 MR1 x^y MR4 / 2 x^y MR3 / MR5                          # 34
e^x = Min6 MR3 FRAC x=0 GOTO2                               # 41
GOTO3                                                       # 42
LBL2 MR6 / MR4 x! = Min6 HLT GOTO7                          # 51
LBL3 MR4 Min3 GOTO5                                         # 55
LBL4 1 M-4 MR3 * MR4 = Min3 MR4                             # 64
LBL5 x=F GOTO6                                              # 67
GOTO4                                                       # 68
LBL6 MR6 / MR3 / PI SQR = Min6 HLT                          # 78
LBL7 1 Min9 0 MinF                                          # 83
LBL8 1 M+7 2 M+8 MR8 * MR9 = Min9                           # 93
MR1 x^y MR7 / MR9 = M+0                                     # 100
MR0 x=F GOTO9                                               # 103
MinF GOTO8                                                  # 105
LBL9 + 1 = * 2 * MR1 / MR2 * MR6 = GOTO1                    # 119
