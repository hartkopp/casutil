# STAT19 - Analysis of variance with two-way layout
# Statistics-19, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-19
# prg code converted from the original document by Claude Code
#
# Input m, n and the data row by row; output ST, SA, SB, SE, VA, VB, VE,
# FA and FB.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT18,
# with prompts and alpha output, same formulas, n in M1F instead of M.F
# and without loop (FX-602P only there).
# The comment behind a line is the step number of the program sheet.
# Total 154
# @calculator 502
# @number 319

*** P0
LBL1 MAC HLT Min1 MinF 0 HLT Min2 Min.F 2 Min0 0            # 12
LBL2 HLT Min3 M+4 x^2 M+6                                   # 18
7 M+2 MR3 IND M+2                                           # 23
7 M-2 0                                                     # 26
IND DSZ GOTO2                                               # 29
DSZ                                                         # 30
IND DSZ GOTO3                                               # 33
GOTO4                                                       # 34
LBL3 MR4 M+5 x^2 M+7 2 Min0 MR.F Min2 0 Min4                # 45
GOTO2                                                       # 46
LBL4 2 Min0 MR.F Min2 0 Min3                                # 53
LBL5 7 M+2 IND MR2 x^2 M+3                                  # 60
7 M-2                                                       # 62
IND DSZ GOTO5                                               # 65
MR4 M+5 x^2 M+7                                             # 69
MR5 x^2 / MRF / MR.F = Min1                                 # 77
MR6 - MR1 = Min2 HLT                                        # 83
MR7 / MR.F - MR1 = Min4 HLT                                 # 91
MR3 / MRF - MR1 = Min5 HLT                                  # 99
MR2 - MR4 - MR5 = Min6 HLT                                  # 107
MR4 / ( MRF - 1 ) = Min7 HLT                                # 117
MR5 / ( MR.F - 1 ) = Min8 HLT                               # 127
MR6 / ( MRF - 1 ) / ( MR.F - 1 ) =                          # 141
Min9 HLT                                                    # 143
MR7 / MR9 = HLT                                             # 148
MR8 / MR9 = GOTO1                                           # 153
