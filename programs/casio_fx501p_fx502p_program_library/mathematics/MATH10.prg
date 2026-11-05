# MATH10 - 4-by-4 determinant
# Mathematics-10, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-10
# prg code converted from the original document by Claude Code
#
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MATH09,
# the same calculation with the registers M01..M16 instead of M1..M.6.
# The comment behind a line is the step number of the program sheet.
# Total 136 (FX-502P only)
# @calculator 502
# @number 110

*** P0
MAC                                                         # 1
LBL1 1 6 Min0 MR.9                                          # 6
LBL2 HLT IND Min0                                           # 10
DSZ GOTO2                                                   # 12
0 Min.9                                                     # 14
MR.6 * MR.1 - MR.2 * MR.5 = Min.7                           # 23
MR6 * MR1 - MR2 * MR5 = Min.8                               # 32
GSBP1                                                       # 33
MR8 * MR.5 - MR.6 * MR7 = Min.7                             # 42
MR.0 * MR1 - MR2 * MR9 = Min.8                              # 51
GSBP1                                                       # 52
MR.6 * MR3 - MR4 * MR.5 = Min.7                             # 61
MR.0 * MR5 - MR6 * MR9 = Min.8                              # 70
GSBP1                                                       # 71
MR.2 * MR7 - MR8 * MR.1 = Min.7                             # 80
MR.4 * MR1 - MR2 * MR.3 = Min.8                             # 89
GSBP1                                                       # 90
MR4 * MR.1 - MR.2 * MR3 = Min.7                             # 99
MR.4 * MR5 - MR6 * MR.3 = Min.8                             # 108
GSBP1                                                       # 109
MR8 * MR3 - MR4 * MR7 = Min.7                               # 118
MR.4 * MR9 - MR.0 * MR.3 = Min.8                            # 127
GSBP1 GOTO1                                                 # 129

*** P1
MR.7 * MR.8 = M+.9                                          # 5
