# GAME04 - Shuffle-number game (reverse)
# Game-4, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Game-4
# prg code converted from the original document by Claude Code
#
# P0 creates a shuffled number of nine digits (the level is entered
# first), P1..P4 reverse parts of it; M1..M9 hold the digits, P5 shows
# the number.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library GAME03,
# with the alpha output "LEVEL", same game.
# The comment behind a line is the step number of the program sheet.
# Total 109
# @calculator 502
# @number 554

*** P5
9 Min0 AC                                                   # 3
LBL1 + IND MR0 * MR0 +/- 10^x = DSZ GOTO1                   # 14
* 9 10^x =                                                  # 18

*** P6
MR1 X<->M4 Min1 MR2 X<->M3 Min2                             # 6

*** P7
MR2 X<->M5 Min2 MR3 X<->M4 Min3                             # 6

*** P8
MR5 X<->M8 Min5 MR6 X<->M7 Min6                             # 6

*** P9
MR6 X<->M9 Min6 MR7 X<->M8 Min7                             # 6

*** P1
GSBP6 GSBP5                                                 # 2

*** P2
GSBP7 GSBP5                                                 # 2

*** P3
GSBP8 GSBP5                                                 # 2

*** P4
GSBP9 GSBP5                                                 # 2

*** P0
MinF AC 9 Min0                                              # 4
LBL1 MR0 IND Min0 DSZ GOTO1 MRF Min0 0                      # 13
LBL3 MinF                                                   # 15
LBL4 RAN# RAN# * 1 0 = INT x=F GOTO4                        # 25
X<->MF 6 X<->MF x>=F GOTO2                                  # 30
+ 4 = x>=F GOTO2 + 3 =                                      # 38
LBL2 X<->M0 X<->Y IND GSBP(0) X<->Y X<->M0 DSZ GOTO3 GSBP5  # 48
MinF                                                        # 49
