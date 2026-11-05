# BANK04 - Calculation for installment plan
# Banking-4, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Banking-4
# prg code converted from the original document by Claude Code
#
# P1 price, P2 down payment, P3 number of installments, P4 interest rate
# per month in %, P0 installment, rounded up to 100.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library BANK04,
# with alpha output, same formulas. P4 is the same in the German
# edition of the FX-501P/FX-502P library.
# The comment behind a line is the step number of the program sheet.
# Total 54
# @calculator 502
# @number 454

*** P1
Min1                                                        # 1

*** P2
Min2                                                        # 1

*** P3
Min3                                                        # 1

*** P4
/ 2 10^x MinF = Min4                                        # 6

*** P0
( MR1 - MR2 ) * MR4 / ( 1 - ( ( 1 +                         # 15
MR4 ) x^y MR3 ) 1/x ) / MRF = Min6                          # 26
INT Min5 MR6 FRAC x=0 GOTO1 1 M+5                           # 34
LBL1 MR5 * MRF = Min5                                       # 40
