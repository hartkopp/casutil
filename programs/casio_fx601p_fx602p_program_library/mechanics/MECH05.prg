# MECH05 - Beam fixed at both ends under concentrated load
# Mechanics-5, description see Program Library FX-601P/FX-602P, page 75 - 76
# prg code converted from the original document by Claude Code
#
# P2 leaves a parenthesis open, which P3 closes.
# The comment behind a line is the step number of the program sheet.
# Total 114
# @calculator 602
# @name "MECH05"
# @mode .20

*** P0
HLT * HLT = Min01 0 HLT Min02 HLT MinF HLT                  # 11
/ MR02 x^y 3 = Min03 0 DEG                                  # 19
LBL1 HLT Min04 x>=F GOTO2 MRF Min08 MR04 Min09              # 28
GSBP1 GOTO1                                                 # 30
LBL2 MR02 - MRF = Min08 MR02 - MR04 =                       # 40
Min09 GSBP1 GOTO1                                           # 43

*** P1
MR09 * ( MR02 + 2 * MR08 ) = Min04                          # 11
MR02 * MR08 = Min05 MR03 * ( MR02 -                         # 21
MR08 ) x^2 = Min06 / 2 / MR01 *                             # 31
MR09 = Min07 / 3 * MR09                                     # 38
GSBP2 3 * GSBP3 HLT                                         # 43
MR07 GSBP2 2 * GSBP3 tan-1 HLT                              # 50
MR06 GSBP2 GSBP3 HLT                                        # 54
MR06 * MR04 / MR09 =                                        # 60

*** P2
* ( MR04 -                                                  # 4

*** P3
MR05 ) =                                                    # 3
