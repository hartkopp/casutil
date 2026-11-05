# MATH13 - Solving a cubic equation by the Newton method
# Mathematics-13, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-13
# prg code converted from the original document by Claude Code
#
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MATH11,
# the same program with prompts, x as alpha text at the end.
# The comment behind a line is the step number of the program sheet.
# Total 81
# @calculator 502
# @number 113

*** P0
HLT Min1 HLT Min2 HLT Min3 HLT Min4 HLT MinF                # 10
LBL1 HLT Min5 HLT Min6                                      # 15
LBL2 MR5 Min7 2 Min0                                        # 20
LBL3 MR1 * MR5 x^2 * MR5 + MR2 * MR5 x^2                    # 32
+ MR3 * MR5 + MR4 = Min9                                    # 40
MR6 M+5                                                     # 42
DSZ GOTO4                                                   # 44
GOTO5                                                       # 45
LBL4 MR9 Min8 GOTO3                                         # 49
LBL5 ( MR9 - MR8 ) / MR6 = Min9                             # 59
MR7 - MR8 / MR9 = Min8 - MR7 = ABS                          # 70
x>=F GOTO6                                                  # 72
GOTO7                                                       # 73
LBL6 MR8 Min5 GOTO2                                         # 77
LBL7 MR7 GOTO1                                              # 80
