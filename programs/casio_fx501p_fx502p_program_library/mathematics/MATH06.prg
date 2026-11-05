# MATH06 - Permutations and combinations
# Mathematics-6, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-6
# prg code converted from the original document by Claude Code
#
# P0 permutation, P1 circular permutation, P2 repeated permutation,
# P3 permutation with same elements, P4 combination, P5 repeated
# combination, P9 subroutine.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MATH06,
# with prompts for n and r in P8 instead of HLT.
# The comment behind a line is the step number of the program sheet.
# Total 127
# @calculator 502
# @number 106

*** P0
Min9 0                                                      # 2
LBL1 HLT Min2 x=0 GOTO3 MR9 Min0 Min1                       # 10
GSBP9                                                       # 11
x=0 GOTO2 GOTO1                                             # 14
LBL2 MR1 x! GOTO1                                           # 18
LBL3 1 GOTO1                                                # 21

*** P1
- 1 = x! HLT                                                # 5

*** P2
Min1 0                                                      # 2
LBL1 HLT Min2 MR1 x^y MR2 = GOTO1                           # 10

*** P3
MAC 1 Min2 0                                                # 4
LBL1 HLT Min0 M+1                                           # 8
MR0 x! * MR2 = Min2                                         # 14
MR1 x! / MR2 = GOTO1                                        # 20

*** P4
Min9 0                                                      # 2
LBL1 HLT Min2 MR9 Min0 Min1                                 # 8
GSBP9                                                       # 9
x=0 GOTO2 / MR2 x! = GOTO1                                  # 16
LBL2 1 GOTO1                                                # 19

*** P5
Min9 0                                                      # 2
LBL1 HLT Min2                                               # 5
MR9 + MR2 - 1 = Min0 Min1                                   # 13
GSBP9                                                       # 14
x=0 GOTO2 / MR2 x! = GOTO1                                  # 21
LBL2 1 GOTO1                                                # 24

*** P9
MR1 - MR2 = MinF 0 x=F GOTO3                                # 8
LBL1 DSZ MR0 x=F GOTO2 * MR1 = Min1                         # 17
GOTO1                                                       # 18
LBL2 MR1                                                    # 20
LBL3                                                        # 21
