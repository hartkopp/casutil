# STAT17 - m-by-n contingency table
# Statistics-17, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-17 (marked "for FX-502P")
# prg code converted from the original document by Claude Code
#
# Up to 5-by-5: input m, n, then the data column by column; output
# chi-square. P1 is a subroutine.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT16,
# with prompts and alpha output, the same algorithm with more registers.
# The comment behind a line is the step number of the program sheet.
# Total 120
# @calculator 502
# @number 317

*** P0
LBL1 MAC HLT MinF Min2 0 HLT Min1 2 Min0                    # 10
LBL2 0 HLT Min3 M+.F                                        # 15
3 M+2 MR3 x^2 IND Min2                                      # 21
1 0 M+2 MR3 IND M+2 1 3 M-2                                 # 30
IND DSZ GOTO2                                               # 33
DSZ                                                         # 34
IND DSZ GOTO3                                               # 37
GOTO4                                                       # 38
LBL3 GSBP1 MRF Min2 0 Min.F GOTO2                           # 45
LBL4 GSBP1 MR.4 + MR.5 + MR.6 + MR.7 + MR.8 =               # 57
Min.F 2 Min0 MRF Min2 0 Min.9                               # 64
LBL5 1 3 M+2 MR2 - 5 = Min1 IND MR1 / IND                   # 77
MR2 = M+.9 1 3 M-2 IND DSZ GOTO5                            # 86
MR.9 - 1 = * MR.F = GOTO1                                   # 94

*** P1
2 Min0 MRF Min2                                             # 4
LBL1 MR2 + 8 = Min.9                                        # 10
3 M+2 IND MR2 / MR.F = IND M+.9                             # 19
3 M-2                                                       # 21
IND DSZ GOTO1                                               # 24
