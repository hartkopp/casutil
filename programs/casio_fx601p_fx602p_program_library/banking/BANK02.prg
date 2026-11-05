# BANK02 - Calculation for loan-repayment II (interest on equally divided
# monthly repayment)
# Banking-2, description see Program Library FX-601P/FX-602P, page 147 - 148
# prg code converted from the original document by Claude Code
#
# P1 loan in 10000, P0 monthly repayment, P2 months, P8 interest rate per
# month and year by iteration.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 120
# @calculator 602
# @name "BANK02"
# @mode .20

*** P1
EXP 4 Min01                                                 # 3

*** P0
Min00 "P=#"                                                 # 6

*** P2
Min02 "n=#"                                                 # 6

*** P8
8 +/- 10^x MinF                                             # 4
MR00 / MR01 - MR01 / MR02 x^2 /                             # 13
MR00 = Min04                                                # 16
LBL1 MR04 Min05 - ( MR01 - ( MR00 / MR05                    # 27
) Min06 * ( 1 - ( ( 1 + MR05 )                              # 39
Min07 x^y MR02 +/- ) Min08 ) Min09 ) /                      # 49
( MR01 - MR06 * ( MR02 * MR08 /                             # 59
MR07 - MR09 / MR05 ) ) = Min04 -                            # 69
MR05 = ABS x>=F GOTO1                                       # 74
MR04 Min03 * 2 10^x = "i(M)=#" HLT * 1 2 = "i(Y)=#"         # 83, 94, 101
