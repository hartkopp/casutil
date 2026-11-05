# MATH01 - Prime factor analysis
# Mathematics-1, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-1
# prg code converted from the original document by Claude Code
#
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MATH01,
# the same program with alpha texts, AC in front and LBL7 and LBL0 moved.
# The comment behind a line is the step number of the program sheet.
# Total 72
# @calculator 502
# @number 101

*** P0
Min1 GOTO2                                                  # 2
LBL1 MR1 / 2 HLT = Min1 - 1 = x=0 GOTO0                     # 14
LBL2 MR1 / 2 = FRAC x=0 GOTO1                               # 22
LBL3 3 Min2                                                 # 25
LBL4 MR1 SQR MinF 1 M+F                                     # 31
LBL5 MR1 / MR2 x>=F GOTO7 =                                 # 38
FRAC x=0 GOTO8                                              # 41
LBL6 2 M+2 GOTO5                                            # 45
LBL7 MR1                                                    # 47
LBL0 HLT AC GOTO0                                           # 51
LBL8 MR1 / MR2 * MR2 - MR1 =                                # 60
x=0 GOTO9 GOTO6                                             # 63
LBL9 MR1 / MR2 HLT = Min1 GOTO4                             # 71
