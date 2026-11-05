# BANK04 - Calculation for installment plan
# Banking-4, description see Program Library FX-601P/FX-602P, page 151 - 152
# prg code converted from the original document by Claude Code
#
# P1 price, P2 down payment, P3 number of installments, P4 interest rate
# per month in %, P0 installment.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 82
# @calculator 602
# @name "BANK04"
# @mode .20

*** P1
Min01 "PT=#"                                                # 7

*** P2
Min02 "R=#"                                                 # 6

*** P3
Min03 "n=#"                                                 # 6

*** P4
/ 2 10^x MinF = Min04 "i(M)=#"                              # 9, 14

*** P0
( MR01 - MR02 ) * MR04 / ( 1 - (                            # 12
( 1 + MR04 ) x^y MR03 ) 1/x ) /                             # 23
MRF = Min06 INT Min05 MR06 FRAC x=0                         # 31
GOTO1 1 M+05                                                # 34
LBL1 MR05 * MRF = "P=#"                                     # 44
