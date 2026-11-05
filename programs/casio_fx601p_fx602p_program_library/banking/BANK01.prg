# BANK01 - Calculation for loan-repayment I (equally divided monthly
# repayment)
# Banking-1, description see Program Library FX-601P/FX-602P, page 145 - 146
# prg code converted from the original document by Claude Code
#
# P1 loan in 10000, P2 years, P3 annual interest rate in %, P0 monthly
# repayment, P5 repayment, P6 present value, P7 months and years.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 130
# @calculator 602
# @name "BANK01"
# @mode .20

*** P1
EXP 4 Min01                                                 # 3

*** P2
* 1 2 = Min02 "n=#"                                         # 10

*** P3
/ 1 2 0 0 * Min03 2 10^x = "i=#"                            # 11, 15

*** P0
Min00 "P=#"                                                 # 6

*** P5
GSBP4 * MR01 = Min00 / 3 10^x + . 5                         # 11
= INT * 3 10^x = "P=#"                                      # 21, 22

*** P6
GSBP4 1/x * MR00 GSBP9 Min01 "PV=#"                         # 8, 12

*** P7
1 - MR03 * MR01 / MR00 = ln /                               # 10
GSBP8 ln +/- GSBP9 Min02 "M=#" HLT / 1 2 = "Y=#"            # 18, 29, 30

*** P4
MR03 / ( 1 - GSBP8 x^y MR02 +/- =                           # 10

*** P9
= Min05 + . 5 = INT                                         # 7

*** P8
( 1 + MR03 )                                                # 5
