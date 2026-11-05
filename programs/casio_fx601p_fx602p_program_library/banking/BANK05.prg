# BANK05 - Calculation of compound annual interest
# Banking-5, description see Program Library FX-601P/FX-602P, page 153 - 154
# prg code converted from the original document by Claude Code
#
# P0 principal, P1 interest rate in %, P2 years, P3..P6 results.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 109
# @calculator 602
# @name "BANK05"
# @mode .20

*** P0
Min00 "R=#"                                                 # 6

*** P1
/ 2 10^x = Min01 GSBP9 MR01 "i=#"                           # 8, 12

*** P2
Min02 GSBP9 MR02 "n=#"                                      # 7, 8

*** P9
( 1 + MR01 ) Min03 x^y MR02 = Min04                         # 10
( 1 - MR04 1/x ) / MR01 = Min05                             # 20
( MR04 - 1 ) / MR01 = Min06                                 # 29

*** P3
MR00 * MR05 GSBP8 "P=#"                                     # 8, 9

*** P4
MR00 * MR03 * MR05 GSBP8 "P=#"                              # 9, 11

*** P5
MR00 * MR06 GSBP8 "S=#"                                     # 8, 9

*** P6
MR00 * MR03 * MR06 GSBP8 "S=#"                              # 9, 11

*** P8
+ . 5 = INT                                                 # 5
