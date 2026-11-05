# STAT10 - Chi-square distribution
# Statistics-10, description see Program Library FX-601P/FX-602P, page 115 - 116
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 145
# @calculator 602
# @name "STAT10"
# @mode .20

*** P0
MAC                                                         # 1
"x" HLT Min01 "v"                                           # 9
HLT Min02 Min08 . 5 MinF                                    # 15
MR02 / 2 = Min03 - 1 = Min04 MR01 /                         # 26
2 = Min05 MR01 x^y MR04 / 2 x^y                             # 35
MR03 / MR05 e^x = Min06 MR03 FRAC                           # 43
x=0 GOTO2                                                   # 45
MR04 Min03 GOTO5                                            # 48
LBL2 MR06 / MR04 x! = Min06 "f(\AR01)=#" HLT GOTO7          # 57, 65
LBL4 1 M-04 MR03 * MR04 = Min03 MR04                        # 74
LBL5 x=F GOTO6                                              # 77
GOTO4                                                       # 78
LBL6 MR06 / MR03 / PI SQR = Min06 "f(\AR01)=#" HLT          # 88, 96
LBL7 1 Min09 0 MinF                                         # 101
LBL8 1 M+07 2 M+08 MR08 * MR09 = Min09                      # 111
MR01 x^y MR07 / MR09 = M+00                                 # 118
MR00 x=F GOTO9                                              # 121
MinF GOTO8                                                  # 123
LBL9 + 1 = * 2 * MR01 / MR02 * MR06 =                       # 136
"P(\AR01)=#"                                                # 144
