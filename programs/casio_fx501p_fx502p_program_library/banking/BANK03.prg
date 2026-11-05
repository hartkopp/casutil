# BANK03 - Calculation for loan-repayment III (equally divided monthly
#          repayment plus extra at bonus times twice a year)
# Banking-3, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Banking-3
# prg code converted from the original document by Claude Code
#
# P0 bonus repayment Q in 10000, P1 loan PV in 10000, P2 years, P3
# annual interest rate in %, P4 e, P6 d, P5 monthly repayment, rounded
# up to 100 yen.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library BANK03,
# with alpha output and FIX7, same formulas. This sheet confirms the
# choices made there against the 602 sheets: x^y MR2, x^y 6 and
# / 2 10^x, which gives the results 58200 and 8400 of the examples.
# The German edition of the FX-501P/FX-502P library (Bankwesen 2) has a
# revised version with 106 steps and the same keys at these places: PV
# in M0 (P0) and Q in M3 (P3) in yen, the monthly interest rate i in M1
# (P1 / 1 2 EXP 2 =), n in M2, e in M4, d in M5 (INV P5), calculation
# in INV P6; (1 + i)^n - 1 is calculated twice instead of kept in M9.
# The comment behind a line is the step number of the program sheet.
# Total 108
# @calculator 502
# @number 453

*** P0
EXP 4 Min0                                                  # 3

*** P1
EXP 4 Min1                                                  # 3

*** P2
* 1 2 = Min2                                                # 5

*** P3
/ 1 2 0 0 * Min3 2 10^x =                                   # 10

*** P4
Min4                                                        # 1

*** P6
Min5                                                        # 1

*** P5
1 + MR3 = Min7 MR4 + MR2 - 6 = Min8                         # 12
MR3 * MR7 x^y ( MR2 - 1 ) / ( MR7 x^y                       # 25
MR2 - 1 ) Min9 * ( MR1 * ( 1 + MR5 * MR3                    # 40
/ 3 0 ) - MR0 * MR9 / MR7 x^y MR8 /                         # 53
( MR7 x^y 6 - 1 ) ) / 2 10^x = Min6                         # 66
FRAC x=0 GOTO1 1 M+6                                        # 71
LBL1 MR6 INT * 2 10^x =                                     # 78
