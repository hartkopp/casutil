# BANK01 - Calculation for loan-repayment I (equally divided monthly
#          repayment)
# Banking-1, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Banking-1
# prg code converted from the original document by Claude Code
#
# P1 loan in 10000, P2 years, P3 annual interest rate in %, P0 monthly
# repayment, P5 repayment, P6 present value, P7 months and years.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library BANK01,
# with alpha output, same formulas (P4 closes the parenthesis here).
# The comment behind a line is the step number of the program sheet.
# Total 95
# @calculator 502
# @number 451

*** P1
EXP 4 Min1                                                  # 3

*** P2
* 1 2 = Min2                                                # 5

*** P3
/ 1 2 0 0 * Min3 2 10^x =                                   # 10

*** P0
Min0                                                        # 1

*** P5
GSBP4 * MR1 = Min0 / 3 10^x + . 5 = INT                     # 13
* 3 10^x =                                                  # 17

*** P6
GSBP4 1/x * MR0 GSBP9 Min1                                  # 6

*** P7
1 - MR3 * MR1 / MR0 = ln / GSBP8 ln +/-                     # 13
GSBP9 Min2 HLT / 1 2 =                                      # 20

*** P4
MR3 / ( 1 - GSBP8 x^y MR2 +/- ) =                           # 11

*** P9
= Min5 + . 5 = INT                                          # 7

*** P8
( 1 + MR3 )                                                 # 5
