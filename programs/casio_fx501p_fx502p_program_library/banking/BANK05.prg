# BANK05 - Calculation of compound annual interest
# Banking-5, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Banking-5
# prg code converted from the original document by Claude Code
#
# P0 principal, P1 interest rate in %, P2 years, P3..P6 results, P8
# rounds them.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library BANK05,
# with alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 84
# @calculator 502
# @number 455

*** P0
Min0 0                                                      # 2

*** P1
/ 2 10^x = Min1 GSBP9 0                                     # 7

*** P2
Min2 GSBP9 0                                                # 3

*** P9
( 1 + MR1 ) Min3 x^y MR2 = Min4                             # 10
( 1 - MR4 1/x ) / MR1 = Min5                                # 20
( MR4 - 1 ) / MR1 = Min6                                    # 29

*** P3
MR0 * MR5 = Min7 GSBP8                                      # 6

*** P4
MR0 * MR3 * MR5 = Min7 GSBP8                                # 8

*** P5
MR0 * MR6 = Min7 GSBP8                                      # 6

*** P6
MR0 * MR3 * MR6 = Min7 GSBP8                                # 8

*** P8
MR7 + . 5 = INT                                             # 6
