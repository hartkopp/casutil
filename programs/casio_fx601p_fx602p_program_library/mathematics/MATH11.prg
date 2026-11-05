# MATH11 - Solving a cubic equation by the Newton method
# Mathematics-11, description see Program Library FX-601P/FX-602P, page 23 - 24
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 114
# @calculator 602
# @name "MATH11"
# @mode .20

*** P0
"a?" HLT Min01                                              # 6
"b?" HLT Min02                                              # 12
"c?" HLT Min03                                              # 18
"d?" HLT Min04                                              # 24
"E0?" HLT MinF                                              # 31
LBL1 "x0?" HLT Min05                                        # 39
"h?" HLT Min06                                              # 45
LBL2 MR05 Min07 2 Min00                                     # 50
LBL3 MR01 * MR05 x^2 * MR05 + MR02 *                        # 60
MR05 x^2 + MR03 * MR05 + MR04 =                             # 69
Min09 MR06 M+05                                             # 72
DSZ GOTO4                                                   # 74
GOTO5                                                       # 75
LBL4 MR09 Min08 GOTO3                                       # 79
LBL5 ( MR09 - MR08 ) / MR06 = Min09                         # 89
MR07 - MR08 / MR09 = Min08 - MR07                           # 98
= ABS x>=F GOTO6 GOTO7                                      # 103
LBL6 MR08 Min05 GOTO2                                       # 107
LBL7 "x=\AR07"                                              # 113
