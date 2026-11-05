# STAT13 - t-distribution
# Statistics-13, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-13
# prg code converted from the original document by Claude Code
#
# Input x and the degrees of freedom v; output the probability I.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT12,
# with prompts and alpha output, same formulas, but without loop and
# with the parts for odd and even v in a different order.
# The comment behind a line is the step number of the program sheet.
# Total 120
# @calculator 502
# @number 313

*** P0
LBL1 RAD MAC HLT Min1 0 HLT Min2 1 MinF Min9 Min0           # 12
MR1 / MR2 SQR = tan-1 Min1 cos x^2 Min6                     # 22
MR2 / 2 = FRAC x=0 GOTO2                                    # 29
GOTO5                                                       # 30
LBL2 MR2 MinF 1 Min7                                        # 35
LBL3 2 M+8 MR8 x=F GOTO4                                    # 41
MR9 * MR7 / MR8 * MR6 = Min9 M+0                            # 51
2 M+7 GOTO3                                                 # 54
LBL4 MR1 sin * MR0 = GOTO1                                  # 61
LBL5 2 * MR1 / PI = Min3 MR2 x=F GOTO6                      # 72
GOTO7                                                       # 73
LBL6 MR3 GOTO1                                              # 76
LBL7 MR2 - 1 = MinF 3 Min7                                  # 84
LBL8 2 M+8 MR8 x=F GOTO9                                    # 90
MR9 * MR8 / MR7 * MR6 = Min9 M+0                            # 100
2 M+7 GOTO8                                                 # 103
LBL9 2 / PI * MR1 cos * MR1 sin * MR0 + MR3 =               # 118
GOTO1                                                       # 119
