# MATH14 - Solving an equation by the midpoint method
# Mathematics-14, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-14
# prg code converted from the original document by Claude Code
#
# P1 holds the function f(x) of x in M3, here the example of the sheet.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MATH12,
# the same program with prompts, x as alpha text at the end.
# The comment behind a line is the step number of the program sheet.
# Total 55
# @calculator 502
# @number 114

*** P0
AC HLT Min1 AC HLT Min2 AC HLT MinF                         # 9
LBL1 MR2 - MR1 = ABS x>=F GOTO2 MR3 HLT                     # 19
LBL2 ( MR1 + MR2 ) / 2 = Min3 GSBP1                         # 30
x>=0 GOTO3 MR3 Min1 GOTO1                                   # 35
LBL3 MR3 Min2 GOTO1                                         # 39

*** P1
MR3 * MR3 * MR3 + MR3 * MR3 - MR3                           # 11
- 1 =                                                       # 14
