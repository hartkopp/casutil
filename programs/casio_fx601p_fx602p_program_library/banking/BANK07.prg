# BANK07 - Calculating for depreciation
# Banking-7, description see Program Library FX-601P/FX-602P, page 157 - 158
# prg code converted from the original document by Claude Code
#
# P1 straight-line method, P2 declining-balance method, P3 input,
# P0 subroutine.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 123
# @calculator 602
# @name "BANK07"
# @mode .20

*** P1
GSBP3                                                       # 1
MinF MR03 1/x * 3 10^x GSBP0                                # 8
1 x=F GOTO1                                                 # 11
MR05 / 2 * 3 10^x + . 5 GSBP0                               # 21
LBL1 MR01 * ( 1 - MR02 ) * MR05 =                           # 32
"Q=#"                                                       # 37

*** P2
GSBP3 * MR03 = Min00                                        # 5
1 - MR02 x^(1/y) MR00 = RND3 Min05                          # 13
LBL1 1 M+06 MR01 * MR05 = INT Min07 M+08                    # 23
"Q\AR06=#" HLT                                              # 30
MR01 - MR07 = Min01 "S\AR06=#"                              # 39, 41
HLT DSZ GOTO1                                               # 44
MR08 "T=#"                                                  # 50

*** P0
= INT / 3 10^x = Min05                                      # 7

*** P3
MAC                                                         # 1
"P" HLT Min01 "r" HLT                                       # 10
/ 2 10^x = Min02 "n" HLT                                    # 19
Min03 "m" HLT Min04                                         # 25
