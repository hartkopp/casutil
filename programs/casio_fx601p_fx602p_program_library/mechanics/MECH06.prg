# MECH06 - Beam fixed at both ends under distributed load
# Mechanics-6, description see Program Library FX-601P/FX-602P, page 77 - 78
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 127
# @calculator 602
# @name "MECH06"
# @mode .20

*** P0
HLT Min01 HLT Min02 HLT Min03 HLT / 2 = Min04               # 11
0                                                           # 12
LBL1 HLT Min05 * MR04 / 6 / MR01 / MR02 =                   # 24
Min06 MR03 x^2 Min07 MR06 / 2 * MR05                        # 33
* ( MR05 * ( 2 * MR03 - MR05 ) -                            # 45
MR07 )                                                      # 47
"y=" PAUSE PAUSE = HLT                                      # 55
MR06 * ( MR05 * ( 3 * MR03 - 2 *                            # 67
MR05 ) - MR07 ) = DEG                                       # 74
"s=" PAUSE PAUSE tan-1 HLT                                  # 82
MR04 / 6 * ( 6 * MR05 * ( MR03 -                            # 94
MR05 ) - MR07 )                                             # 99
"M=" PAUSE PAUSE = HLT                                      # 107
MR04 +/- * ( 2 * MR05 - MR03 )                              # 117
"Ws=" PAUSE PAUSE =                                         # 125
GOTO1                                                       # 126
