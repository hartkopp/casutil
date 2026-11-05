# MATH07 - Complex arithmetics
# Mathematics-7, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-7
# prg code converted from the original document by Claude Code
#
# P0 sum and difference, P1 product, P2 quotient, P3 n-th power, P4 n-th
# root, P7..P9 subroutines.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MATH07,
# the same program.
# The comment behind a line is the step number of the program sheet.
# Total 115
# @calculator 502
# @number 107

*** P0
AC                                                          # 1
MAC HLT X<->M1 HLT X<->M2 HLT X<->M3 HLT X<->M4             # 10
MR1 + MR3 M-1 = HLT MR2 + MR4 M-2 = HLT                     # 22
MR1 HLT MR2                                                 # 25

*** P1
AC                                                          # 1
GSBP8 GSBP7 0 GSBP8 X<->Y M+2                               # 7
X<->Y * MR1 = GSBP9                                         # 12

*** P2
AC                                                          # 1
GSBP8 GSBP7 0 GSBP8 X<->Y M-2                               # 7
X<->Y / MR1 X<->Y = GSBP9                                   # 13

*** P3
Min0 AC GSBP8 GSBP7 MR2 * MR0 = Min2                        # 9
MR1 x^y MR0 = GSBP9                                         # 14

*** P4
Min0 DEG AC GSBP8 GSBP7 MR1 x^(1/y) MR0 =                   # 9
Min1 MR2 / MR0 = Min2 3 6 0 / MR0 = Min3                    # 22
LBL1 MR3 M+2 MR1 GSBP9 HLT DSZ GOTO1                        # 30

*** P7
Min1 X<->Y Min2                                             # 3

*** P8
HLT R->P 0 HLT =                                            # 5

*** P9
P->R MR2 = HLT X<->Y                                        # 5
