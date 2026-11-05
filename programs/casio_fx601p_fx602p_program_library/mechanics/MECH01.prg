# MECH01 - Cantilever under concentrated load
# Mechanics-1, description see Program Library FX-601P/FX-602P, page 67 - 68
# prg code converted from the original document by Claude Code
#
# P0 input and calculation, P1 deflection y, P2 slope, P3 moment M.
# The comment behind a line is the step number of the program sheet.
# Total 118
# @calculator 602
# @name "MECH01"
# @mode .20

*** P0
HLT Min01 HLT Min02 HLT Min03 MinF HLT Min04                # 9
/ 2 / MR01 / MR02 = Min06 / 3 =                             # 20
Min07 0 DEG                                                 # 23
LBL1 HLT Min05 x>=F GOTO2 GOTO3                             # 29
LBL2 MR07 * MR03 x^y 3 - MR06 * MR03                        # 39
x^2 * MR05 GSBP1                                            # 43
MR06 * MR03 x^2 = +/- GSBP2                                 # 50
0 GSBP3 GOTO1                                               # 53
LBL3 MR07 * MR05 x^y 3 - MR06 * MR03                        # 63
* MR05 x^2 = GSBP1                                          # 68
MR06 * MR05 * ( MR05 - 2 * MR03 )                           # 79
= GSBP2                                                     # 81
MR04 * ( MR05 - MR03 ) GSBP3 GOTO1                          # 90

*** P1
"y=" PAUSE PAUSE = HLT                                      # 8

*** P2
"s=" PAUSE PAUSE tan-1 HLT                                  # 8

*** P3
"M=" PAUSE PAUSE = HLT                                      # 8
