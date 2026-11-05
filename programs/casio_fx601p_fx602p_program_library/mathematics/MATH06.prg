# MATH06 - Permutations and combinations
# Mathematics-6, description see Program Library FX-601P/FX-602P, page 11 - 14
# prg code converted from the original document by Claude Code
#
# P0 permutation, P1 circular permutation, P2 repeated permutation,
# P3 permutation with same elements, P4 combination, P5 repeated
# combination, P8 and P9 subroutines.
# The listing follows the English sheet with 212 steps, the Japanese
# edition has another version of the program with 210 steps.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 212 (P0..P4 on page 12, P5, P8, P9 on page 14, FX-602P only)
# @calculator 602
# @name "MATH06"
# @mode .20

*** P0
MAC                                                         # 1
LBL1 GSBP8 x=0 GOTO3 MR09 Min00 Min01                       # 8
GSBP9 x=0 GOTO2 GOTO4                                       # 12
LBL2 MR01 x! GOTO4                                          # 16
LBL3 1                                                      # 18
LBL4 "\AR09P\AR02=#" HLT                                    # 27
GOTO1                                                       # 28

*** P1
LBL1 "n?" HLT "(#-1)!=" - 1 = x!                            # 9, 19
";#" HLT GOTO1                                              # 25

*** P2
"n?" HLT Min01 0                                            # 7
LBL1 "r?" HLT Min02 MR01 x^y                                # 16
MR02 = "\AR01E \AR02=#" HLT GOTO1                           # 24, 28

*** P3
MAC 1 Min02 0                                               # 4
LBL1 HLT Min00 M+01 x! * MR02 = Min02 MR01                  # 14
x! / MR02 = "<n=\AR01>=#" GOTO1                             # 23, 28

*** P4
MAC                                                         # 1
LBL1 GSBP8 MR09 Min00 Min01 GSBP9 x=0                       # 8
GOTO2 / MR02 x! = GOTO3                                     # 14
LBL2 1                                                      # 16
LBL3 "\AR09C\AR02=#" HLT                                    # 25
GOTO1                                                       # 26

*** P5
LBL1 GSBP8 MR09 + MR02 - 1 = Min00 Min01                    # 10
GSBP9 x=0 GOTO2 / MR02 x! = GOTO3                           # 18
LBL2 1                                                      # 20
LBL3 "\AR09H\AR02=#" HLT                                    # 29
GOTO1                                                       # 30

*** P8
MR09 "n=#?" HLT                                             # 8
Min09                                                       # 9
MR02 "r=#?" HLT                                             # 17
Min02                                                       # 18

*** P9
MR01 - MR02 = MinF 0 x=F GOTO3                              # 8
LBL1 DSZ MR00 x=F GOTO2 * MR01 = Min01                      # 17
GOTO1                                                       # 18
LBL2 MR01                                                   # 20
LBL3                                                        # 21
