# STAT16 - m-by-n contingency table
# Statistics-16, description see Program Library FX-601P/FX-602P, page 127 - 128
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 164 (FX-602P only)
# @calculator 602
# @name "STAT16"
# @mode .61

*** P0
MAC                                                         # 1
"m" HLT MinF Min02                                          # 7
"n" HLT Min01 2 Min00                                       # 14
1 Min58 Min59                                               # 19
LBL2 "x\AR58,\AR59" HLT Min03                               # 30
M+1F 3 M+02 MR03 x^2 IND Min02                              # 37
3 6 M+02 MR03 IND M+02 3 9 M-02                             # 46
1 M+58 IND DSZ GOTO2                                        # 52
DSZ IND DSZ GOTO3                                           # 56
GOTO4                                                       # 57
LBL3 GSBP1 MRF Min02 0 Min1F 1 Min58 M+59                   # 68
GOTO2                                                       # 69
LBL4 GSBP1 1 7 Min00 5 7 Min58 MR57 Min1F                   # 81
LBL6 1 M-58 IND MR58 M+1F DSZ GOTO6                         # 91
2 Min00 MRF Min02 0 Min60                                   # 98
LBL5 3 9 M+02 MR02 - 1 8 = Min01                            # 108
IND MR01 / IND MR02 = M+60                                  # 116
3 9 M-02 IND DSZ GOTO5                                      # 122
MR60 - 1 = * MR1F =                                         # 130
"X=#"                                                       # 135

*** P1
2 Min00 MRF Min02                                           # 4
LBL1 MR02 + 2 1 = Min60                                     # 12
3 M+02 IND MR02 / MR1F = IND M+60                           # 22
3 M-02 IND DSZ GOTO1                                        # 27
