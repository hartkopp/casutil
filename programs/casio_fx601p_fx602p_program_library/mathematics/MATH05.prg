# MATH05 - Polynomial calculations
# Mathematics-5, description see Program Library FX-601P/FX-602P, page 9 - 10
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 90
# @calculator 602
# @name "MATH05"
# @mode .20

*** P0
MAC "(n)?" HLT                                              # 8
Min00 MinF 1 M+F                                            # 12
LBL1 AC "(a\AR00)?" HLT IND Min00 DSZ GOTO1                 # 20, 26
MRF Min00 1 M+00                                            # 30
AC "(a0)?" HLT                                              # 39
IND Min00 AC                                                # 42
LBL2 "(x)?" HLT "f(#)" IND MinF                             # 51, 58
MRF Min00 1 M-00 AC                                         # 63
LBL3 IND MR00 = * IND MRF + DSZ GOTO3                       # 73
MRF Min00 1 M+00 0 + IND MR00 =                             # 82
";=#" HLT GOTO2                                             # 89
