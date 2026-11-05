# MATH13 - Definite integral by the Simpson's rule
# Mathematics-13, description see Program Library FX-601P/FX-602P, page 27 - 28
# prg code converted from the original document by Claude Code
#
# P1 holds the function f(x) of x in M07, here the example of the sheet.
# The comment behind a line is the step number of the program sheet.
# Total 78
# @calculator 602
# @name "MATH13"
# @mode .20

*** P0
LBL1 "a?" HLT Min01                                         # 7
"b?" HLT Min02                                              # 13
"2m?" HLT Min03                                             # 20
MR01 Min07 GSBP1 Min09                                      # 24
( MR02 - MR01 ) / MR03 = Min04                              # 33
MR03 / 2 = Min00                                            # 38
LBL2 MR04 M+07 GSBP1 * 4 = M+09                             # 46
MR04 M+07 GSBP1 * 2 = M+09                                  # 53
DSZ GOTO2                                                   # 55
MR02 Min07 GSBP1 M-09                                       # 59
MR04 * MR09 / 3 =                                           # 65
"I=#"                                                       # 70

*** P1
MR07 x^2 + 1 = 1/x                                          # 6
