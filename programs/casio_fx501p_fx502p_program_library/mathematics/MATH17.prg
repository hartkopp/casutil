# MATH17 - Bessel function of the first kind and n-th order
# Mathematics-17, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-17
# prg code converted from the original document by Claude Code
#
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MATH15,
# the same program with prompts.
# The comment behind a line is the step number of the program sheet.
# Total 66
# @calculator 502
# @number 117

*** P0
LBL1 MAC HLT / 2 = Min1 x^2 Min3 0 HLT Min2 Min6            # 13
x! Min9 1/x Min0                                            # 17
LBL2 1 M+4 M+5 M+6                                          # 22
MR9 * MR6 * MR5 = Min9                                      # 29
MR4 / 2 = FRAC x=0 GOTO3                                    # 36
GOTO4                                                       # 37
LBL3 GSBP1 M+0 GOTO5                                        # 41
LBL4 GSBP1 M-0                                              # 44
LBL5 MR0 x=F GOTO6                                          # 48
MinF GOTO2                                                  # 50
LBL6 MR1 x^y MR2 * MR0 = GOTO1                              # 58

*** P1
MR3 x^y MR4 / MR9 =                                         # 6
