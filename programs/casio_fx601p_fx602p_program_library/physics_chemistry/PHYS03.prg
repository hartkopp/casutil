# PHYS03 - Thermal conduction through layers
# Physics/chemistry-3, description see Program Library FX-601P/FX-602P,
# page 91 - 92
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 124
# @calculator 602
# @name "PHYS03"
# @mode .20

*** P0
LBL2 MAC GSBP1 ";x" HLT Min01                               # 9
GSBP1 ";y" HLT * MR01 =                                     # 18
Min09                                                       # 19
LBL3 ISZ                                                    # 21
GSBP1 ";l\AR00" HLT Min07                                   # 29
GSBP1 ";k\AR00" HLT Min08                                   # 37
MR07 / MR08 / MR09 = IND Min00 M+F                          # 46
6 - MR00 = x=0 GOTO1 GOTO3                                  # 53
LBL1 GSBP1 ";T0" HLT Min07                                  # 62
GSBP1 ";Tn" HLT Min08                                       # 70
"q=" GSBP2 ( MR07 - MR08                                    # 79
) / MRF = Min09 HLT                                         # 85
MR00 = MinF 0 Min00                                         # 90
LBL4 ISZ MR00 x=F GOTO2                                     # 95
"T\AR00=" GSBP2 MR07 - MR09                                 # 104
* IND MR00 = Min07 HLT GOTO4                                # 111

*** P1
"INPUT "                                                    # 8

*** P2
PAUSE PAUSE                                                 # 2
