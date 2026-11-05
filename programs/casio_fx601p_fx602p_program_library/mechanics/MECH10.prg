# MECH10 - Thermal stress
# Mechanics-10, description see Program Library FX-601P/FX-602P, page 85 - 86
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 107
# @calculator 602
# @name "MECH10"
# @mode .20

*** P0
LBL1 "L1=?" HLT Min01                                       # 9
"L2=?" HLT Min02                                            # 17
"E1=?" HLT Min03                                            # 25
"E2=?" HLT Min04                                            # 33
"A1=?" HLT Min05                                            # 41
"A2=?" HLT Min06                                            # 49
"T=?" HLT Min07                                             # 56
( MR03 * MR04 * ( MR01 - MR02 )                             # 66
* MR07 ) / ( MR03 * MR05 + MR04 *                           # 77
MR06 ) = Min08 * MR06 +/-                                   # 84
"S1=" PAUSE PAUSE = HLT                                     # 93
MR08 * MR05                                                 # 96
"S2=" PAUSE PAUSE = HLT GOTO1                               # 106
