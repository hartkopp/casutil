# MATH03 - Decimal - base-N conversion (n = 2 - 9)
# Mathematics-3, description see Program Library FX-601P/FX-602P, page 5 - 6
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 123
# @calculator 602
# @name "MATH03"
# @mode .20

*** P1
AC "<10\->n> \-> n?" HLT x=0 GOTO1                          # 9, 17
MinF Min01 1 0 Min02 GSBP2                                  # 23
LBL1 "<n\->10> \-> n?" HLT Min02 1 0                        # 32, 41
Min01 AC MinF GSBP2                                         # 45

*** P2
LBL1 AC "INPUT <x>" HLT Min03 0 Min00 Min04                 # 11, 18
LBL2 MR03 / MR01 = INT Min05 x=0 GOTO3                      # 27
MR03 - MR05 * MR01 = GSBP3 MR05 Min03                       # 36
ISZ GOTO2                                                   # 38
LBL3 MR03 GSBP3 AC x=F GOTO4 "<10\->\AR01>" PAUSE MR04 HLT  # 48, 55
GOTO1                                                       # 56
LBL4 "<\AR02\->10>"                                         # 65
PAUSE MR04 HLT GOTO1                                        # 69

*** P3
* MR02 x^y MR00 = M+04                                      # 6
