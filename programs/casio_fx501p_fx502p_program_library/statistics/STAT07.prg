# STAT07 - Regression analysis (linear, exponential, logarithmic, power)
# Statistics-7, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-7
# prg code converted from the original document by Claude Code
#
# P0 data input, P1 regression and estimate. The type of the regression
# (1 linear, 2 exponential, 3 logarithmic, 4 power) is entered first
# into M1, it selects the jumps with IND.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT06,
# with alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 117
# @calculator 502
# @number 307

*** P0
MAC Min1 + 4 = Min2                                         # 6
LBL0 ISZ MR0 HLT IND GOTO1                                  # 12
LBL4                                                        # 13
LBL3 ln                                                     # 15
LBL2                                                        # 16
LBL1 xD * 0 HLT IND GOTO2                                   # 23
LBL8                                                        # 24
LBL6 ln                                                     # 26
LBL7                                                        # 27
LBL5 M+5 Min3 = M+6 MR3 x^2 M+4 GOTO0                       # 36

*** P1
1 Min0 MR6 - xbar * MR5 = / ( MR7 -                         # 12
xbar * MR8 ) = MinF                                         # 18
MR5 / MR9 - MRF * xbar = Min3 IND GOTO2                     # 29
LBL0 HLT MR3 * MR5 + MRF HLT * MR6 - MR5 x^2                # 42
/ MR9 = / ( MR4 - MR5 x^2 / MR9 ) =                         # 55
LBL9 HLT IND GOTO1                                          # 59
LBL4                                                        # 60
LBL3 ln                                                     # 62
LBL2                                                        # 63
LBL1 * MRF + MR3 = IND GOTO2                                # 71
LBL8                                                        # 72
LBL6 e^x                                                    # 74
LBL7                                                        # 75
LBL5 DSZ GOTO9 GOTO0                                        # 79
