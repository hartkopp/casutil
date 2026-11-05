# MATH15 - Definite integral by the Simpson's rule
# Mathematics-15, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-15
# prg code converted from the original document by Claude Code
#
# P1 holds the function f(x) of x in M7, here the example of the sheet.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MATH13,
# the same program with prompts, I as alpha text at the end.
# The comment behind a line is the step number of the program sheet.
# Total 61
# @calculator 502
# @number 115

*** P0
LBL1 HLT Min1 HLT Min2 HLT Min3                             # 7
MR1 Min7 GSBP1 Min9                                         # 11
( MR2 - MR1 ) / MR3 = Min4                                  # 20
MR3 / 2 = Min0                                              # 25
LBL2 MR4 M+7 GSBP1 * 4 = M+9                                # 33
MR4 M+7 GSBP1 * 2 = M+9                                     # 40
DSZ GOTO2                                                   # 42
MR2 Min7 GSBP1 M-9                                          # 46
MR4 * MR9 / 3 = GOTO1                                       # 53

*** P1
MR7 x^2 + 1 = 1/x                                           # 6
