# BANK03 - Calculation for loan-repayment III (equally divided monthly
# repayment plus extra at bonus times twice a year)
# Banking-3, description see Program Library FX-601P/FX-602P, page 149 - 150
# prg code converted from the original document by Claude Code
#
# P0 bonus repayment Q in 10000, P1 loan PV in 10000, P2 years, P3
# annual interest rate in %, P4 e, P6 d, P5 monthly repayment.
# The listing follows the English sheet. The Japanese sheet differs in
# line 16 (x^2 instead of MR07 x^y MR02) and line 20 (FIX and MR06
# instead of FRAC and M+06), the English sheet is right there.
# Errors of both sheets in line 19 of P5. A line with "fix:" behind the
# step number is split at the error and "fix:" gives its replacement:
# - MR07 10^x 6 (English, the Japanese sheet has x^y): the program
#   calculates (1 + i)^6 - 1 for the bonus every 6 months, MR07 x^y 6.
# - / 2 x^y = (both sheets): the repayment is divided by 100 for the
#   rounding to 100 yen, / 2 10^x =. Only this gives the results 58200
#   and 8400 of the examples.
# The fixes keep the number of steps. The FX-501P/FX-502P version
# (casio_fx501p_fx502p_program_library BANK03) and the German edition of
# the FX-501P/FX-502P library have the correct keys.
# The comment behind a line is the step number of the program sheet.
# Total 135
# @calculator 602
# @name "BANK03"
# @mode .20

*** P0
EXP 4 Min00                                                 # 3

*** P1
EXP 4 Min01                                                 # 3

*** P2
* 1 2 = Min02 "n=#"                                         # 10

*** P3
/ 1 2 0 0 * Min03 2 10^x = FIX7 "i=#"                       # 11, 17

*** P4
Min04 "e=#"                                                 # 6

*** P6
Min05 "d=#"                                                 # 6

*** P5
1 + MR03 = Min07 MR04 + MR02 - 6 =                          # 11
Min08 MR03 * MR07 x^y ( MR02 - 1 )                          # 21
/ ( MR07 x^y MR02 - 1 ) Min09 * (                           # 32
MR01 * ( 1 + MR05 * MR03 / 3 0 )                            # 44
- MR00 * MR09 / MR07 x^y MR08 / (                           # 54
MR07 10^x                                                   # 56 fix: MR07 x^y
6 - 1 ) ) / 2                                               # 63
x^y =                                                       # 65 fix: 10^x =
Min06 FRAC x=0 GOTO1 1 M+06                                 # 71
LBL1 MR06 INT * 2 10^x = "P=#"                              # 82, 83
