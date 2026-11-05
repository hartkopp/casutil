# BANK02 - Calculation for loan-repayment II (interest on equally divided
#          monthly repayment)
# Banking-2, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Banking-2
# prg code converted from the original document by Claude Code
#
# P1 loan in 10000, P0 monthly repayment, P2 months, P8 interest rate per
# month and year by iteration.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library BANK02,
# with alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 94
# @calculator 502
# @number 452

*** P1
EXP 4 Min1                                                  # 3

*** P0
Min0                                                        # 1

*** P2
Min2                                                        # 1

*** P8
8 +/- 10^x MinF                                             # 4
MR0 / MR1 - MR1 / MR2 x^2 / MR0 = Min4                      # 16
LBL1 MR4 Min5 - ( MR1 - ( MR0 / MR5 ) Min6                  # 29
* ( 1 - ( ( 1 + MR5 ) Min7 x^y MR2 +/-                      # 43
) Min8 ) Min9 ) / ( MR1 - MR6 * ( MR2                       # 56
* MR8 / MR7 - MR9 / MR5 ) ) = Min4                          # 68
- MR5 = ABS x>=F GOTO1                                      # 74
MR4 Min3 * 2 10^x = HLT * 1 2 =                             # 85
