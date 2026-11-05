# STAT12 - F-distribution
# Statistics-12, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-12
# prg code converted from the original document by Claude Code
#
# Input x and the degrees of freedom v1 and v2; output Q(x), 0 if both
# v1 and v2 are odd.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT11,
# with prompts and alpha output, same formulas, but without loop and
# with slightly rearranged jumps.
# The comment behind a line is the step number of the program sheet.
# Total 170
# @calculator 502
# @number 312

*** P0
LBL0 MAC HLT Min1 0 HLT Min2 0 HLT Min3 / ( MR3 +           # 14
MR1 * MR2 ) = Min6 1 Min0 Min9 MinF                         # 24
MR3 / 2 = Min5 MR2 / 2 = FRAC x=0 GOTO1                     # 36
GOTO3                                                       # 37
LBL1 MR5 FRAC x=0 GOTO2                                     # 42
GOTO4                                                       # 43
LBL2 MR2 - MR3 = x>=0 GOTO5                                 # 50
GOTO4                                                       # 51
LBL3 MR5 FRAC x=0 GOTO5                                     # 56
0 GOTO0                                                     # 58
LBL4 0 Min1 Min5 MR3 Min4 1 - MR6 = Min7                    # 69
( MR2 - 2 ) / 2 = x=F GOTO7                                 # 79
MinF GOTO6                                                  # 81
LBL5 1 Min1 0 Min5 MR2 Min4 MR6 Min7                        # 90
( MR3 - 2 ) / 2 = x=F GOTO7 MinF                            # 101
LBL6 1 M+8 MR8 x=F GOTO7                                    # 107
2 M+5 MR9 * MR4 / MR5 * MR7 = Min9                          # 118
M+0 2 M+4 GOTO6                                             # 122
LBL7 MR9 * MR4 / ( MR5 + 2 ) * MR7 = M+0                    # 136
MR1 x=0 GOTO8                                               # 139
1 - MR6 = Min7 1 - MR0 * MR7 x^y (                          # 151
MR2 / 2 ) = GOTO0                                           # 157
LBL8 MR0 * MR6 x^y ( MR3 / 2 ) = GOTO0                      # 169
