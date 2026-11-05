# MECH03 - Simple beam under concentrated load
# Mechanics-3, description see Program Library FX-601P/FX-602P, page 71 - 72
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 120
# @calculator 602
# @name "MECH03"
# @mode .20

*** P0
HLT Min01 HLT Min02 HLT Min03 HLT MinF HLT                  # 9
Min04 DEG                                                   # 11
LBL1 HLT Min05 x>=F GOTO2 GOTO3                             # 17
LBL2 MRF +/- Min08 MR05 - MR03 = GSBP1 GOTO1                # 27
LBL3 MR03 - MRF = Min08 MR05 GSBP1 GOTO1                    # 36

*** P1
Min09 MR04 * MR08 / MR03 = Min06 / 6                        # 10
/ MR01 / MR02 = Min07 * MR09 *                              # 19
( GSBP2 GSBP3                                               # 22
MR07 * ( 3 * GSBP2 = GSBP4                                  # 30
MR06 * MR09 GSBP5                                           # 34
MR06 GSBP6                                                  # 36

*** P2
MR09 x^2 + MR08 x^2 - MR03 x^2 )                            # 9

*** P3
"y=" PAUSE PAUSE = HLT                                      # 8

*** P4
"s=" PAUSE PAUSE tan-1 HLT                                  # 8

*** P5
"M=" PAUSE PAUSE = HLT                                      # 8

*** P6
"Ws=" PAUSE PAUSE =                                         # 8
