# GAME03 - Shuffle-number game
# Game-3, description see Program Library FX-601P/FX-602P, page 173 - 174
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 118
# @calculator 602
# @name "GAME03"
# @mode .20

*** P5
9 Min00 AC                                                  # 3
LBL1 + IND MR00 * MR00 +/- 10^x = DSZ                       # 13
GOTO1 * 9 10^x =                                            # 18

*** P6
MR01 X<->M04 Min01 MR02 X<->M03 Min02                       # 6

*** P7
MR02 X<->M05 Min02 MR03 X<->M04 Min03                       # 6

*** P8
MR05 X<->M08 Min05 MR06 X<->M07 Min06                       # 6

*** P9
MR06 X<->M09 Min06 MR07 X<->M08 Min07                       # 6

*** P1
GSBP6 GSBP5                                                 # 2

*** P2
GSBP7 GSBP5                                                 # 2

*** P3
GSBP8 GSBP5                                                 # 2

*** P4
GSBP9 GSBP5                                                 # 2

*** P0
MinF "LEVEL #" AC                                           # 11
9 Min00                                                     # 13
LBL1 MR00 IND Min00 DSZ GOTO1 MRF Min00 0                   # 22
LBL3 MinF                                                   # 24
LBL4 RAN# RAN# * 1 0 = INT x=F GOTO4                        # 34
X<->MF 6 X<->MF x>=F GOTO2                                  # 39
+ 4 = x>=F GOTO2 + 3 =                                      # 47
LBL2 X<->M00 X<->Y IND GSBP(0) X<->Y X<->M00 DSZ            # 55
GOTO3 GSBP5 MinF                                            # 58
