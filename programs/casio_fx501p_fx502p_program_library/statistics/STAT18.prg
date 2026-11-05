# STAT18 - Analysis of variance with one-way layout
# Statistics-18, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-18
# prg code converted from the original document by Claude Code
#
# Input m, n and the data (0 for a missing value); output ST, SP, SE,
# MST, MSE and F. P1 is a subroutine.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT17,
# with prompts and alpha output, same formulas, but without loop and
# with the evaluation directly behind the input loop.
# The comment behind a line is the step number of the program sheet.
# Total 116
# @calculator 502
# @number 318

*** P0
LBL1 MAC HLT Min1 Min8 0 HLT Min2 Min9 2 Min0               # 11
LBL2 0 HLT x=0 GOTO6 M+3 x^2 M+4                            # 19
LBL3 IND DSZ GOTO2                                          # 23
DSZ                                                         # 24
IND DSZ GOTO4                                               # 27
GOTO5                                                       # 28
LBL4 GSBP1 2 Min0 MR9 Min2 0 Min3 MinF GOTO2                # 38
LBL5 GSBP1 MR8 * MR9 - MR7 = Min7                           # 47
MR5 x^2 / MR7 = Min1                                        # 53
MR4 - MR1 = Min2 HLT                                        # 59
MR6 - MR1 = Min3 HLT                                        # 65
MR2 - MR3 = Min4 HLT                                        # 71
MR3 / ( MR8 - 1 ) = Min5 HLT                                # 81
MR4 / ( MR7 - MR8 ) = Min6 HLT                              # 91
MR5 / MR6 = GOTO1                                           # 96
LBL6 1 M+F 0 GOTO3                                          # 101

*** P1
MR3 M+5 x^2 / ( MR9 - MRF ) = M+6                           # 11
MRF M+7                                                     # 13
