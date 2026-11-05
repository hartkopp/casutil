# BANK08 - Calculation of aggregate classification and prorating
# Banking-8, description see Program Library FX-601P/FX-602P, page 159 - 160
# prg code converted from the original document by Claude Code
#
# P0 input of the data, P1 totals and ratios, P4 subroutine.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 106
# @calculator 602
# @name "BANK08"
# @mode .70

*** P0
MAC                                                         # 1
LBL1 "No.?" HLT Min00 x>=F                                  # 11
MinF "No.\AR00\->DATA?" HLT IND M+00 GOTO1                  # 20, 28

*** P1
MRF Min00 AC                                                # 3
LBL1 + IND MR00 DSZ                                         # 8
GOTO1 = "T=#" HLT ISZ                                       # 17
/ 4 10^x = X<->M01 GSBP4 ISZ                                # 24
X<->M02 GSBP4 M+02 2 Min00 x=F GOTO3                        # 31
LBL2 ISZ IND MR00 GSBP4 M+02                                # 37
MR00 x=F GOTO3 GOTO2                                        # 41
LBL3 MR02 "TP=#"                                            # 49

*** P4
"No.\AR00=#" HLT                                            # 9
/ MR01 + . 5 = INT / 2 10^x =                               # 20
"P=#" HLT                                                   # 26
