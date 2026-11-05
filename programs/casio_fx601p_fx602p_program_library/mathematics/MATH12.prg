# MATH12 - Solving an equation by the midpoint method
# Mathematics-12, description see Program Library FX-601P/FX-602P, page 25 - 26
# prg code converted from the original document by Claude Code
#
# P1 holds the function f(x) of x in M03, here the example of the sheet.
# The comment behind a line is the step number of the program sheet.
# Total 69
# @calculator 602
# @name "MATH12"
# @mode .20

*** P0
"a?" HLT Min01                                              # 6
"b?" HLT Min02                                              # 12
"E?" HLT MinF                                               # 18
LBL1 MR02 - MR01 = ABS x>=F GOTO2 GOTO4                     # 27
LBL2 ( MR01 + MR02 ) / 2 = Min03 GSBP1                      # 38
x>=0 GOTO3 MR03 Min01 GOTO1                                 # 43
LBL3 MR03 Min02 GOTO1                                       # 47
LBL4 "x=\AR03"                                              # 53

*** P1
MR03 * MR03 * MR03 + MR03 * MR03 -                          # 10
MR03 - 1 =                                                  # 14
