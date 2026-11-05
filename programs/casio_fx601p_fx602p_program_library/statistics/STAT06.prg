# STAT06 - Regression analysis (linear, exponential, logarithmic, power)
# Statistics-6, description see Program Library FX-601P/FX-602P, page 107 - 108
# prg code converted from the original document by Claude Code
#
# P0 data input, P1 regression and estimate. M01 selects the type of the
# regression for the jumps with IND.
# The comment behind a line is the step number of the program sheet.
# Total 148
# @calculator 602
# @name "STAT06"
# @mode .20

*** P0
MAC Min01 Min02 4 M+02                                      # 5
LBL0 ISZ MR00 "x#" HLT                                      # 13
IND GOTO1                                                   # 15
LBL4                                                        # 16
LBL3 ln                                                     # 18
LBL2                                                        # 19
LBL1 xD * MR00 "y#" HLT                                     # 28
IND GOTO2                                                   # 30
LBL8                                                        # 31
LBL6 ln                                                     # 33
LBL7                                                        # 34
LBL5 M+05 Min03 = M+06 MR03 x^2 M+04 GOTO0                  # 43

*** P1
1 Min00 MR06 - xbar * MR05 = / (                            # 10
MR07 - xbar * MR08 ) = MinF                                 # 18
MR05 / MR09 - MRF * xbar = Min03                            # 27
IND GOTO2                                                   # 29
LBL0 "a=#" HLT MR03 * MR05 +                                # 40
MRF "b=#" HLT * MR06                                        # 49
- MR05 x^2 / MR09 = / ( MR04 -                              # 59
MR05 x^2 / MR09 ) = "r2=#"                                  # 69, 71
HLT IND GOTO1                                               # 74
LBL9 "y=#" HLT IND GOTO1                                    # 83
LBL4                                                        # 84
LBL3 ln                                                     # 86
LBL2                                                        # 87
LBL1 * MRF + MR03 = IND GOTO2                               # 95
LBL8                                                        # 96
LBL6 e^x                                                    # 98
LBL7                                                        # 99
LBL5 DSZ GOTO9 GOTO0                                        # 103
