# MATH14 - Solving ordinary differential equation of the first order by
# the Runge-Kutta method
# Mathematics-14, description see Program Library FX-601P/FX-602P, page 29 - 30
# prg code converted from the original document by Claude Code
#
# P1 holds the function f(x, y) of x in M04 and y in M05, here the
# example of the sheet.
# The comment behind a line is the step number of the program sheet.
# Total 120
# @calculator 602
# @name "MATH14"
# @mode .20

*** P0
MAC                                                         # 1
"x0?" HLT Min01                                             # 8
"y0?" HLT Min02                                             # 15
"h?" HLT Min03 / 2 =                                        # 24
Min00                                                       # 25
LBL1 1 M+F MR01 Min04 MR02 Min05 GSBP1 Min06                # 34
MR01 + MR00 = Min04 MR02 + MR06 / 2                         # 44
= Min05 GSBP1 Min07 / 2 + MR02 = Min05                      # 54
GSBP1 Min08 + MR02 = Min05 MR01 + MR03                      # 63
= Min04 GSBP1 Min09 MR01 + MR03 = Min01                     # 72
"x\ARF=#" HLT                                               # 79
MR02 + ( MR06 + 2 * MR07 + 2 *                              # 90
MR08 + MR09 ) / 6 = Min02                                   # 98
"y\ARF=#" HLT GOTO1                                         # 106

*** P1
3 * MR05 / ( 1 + MR04 ) * MR03 =                            # 12
