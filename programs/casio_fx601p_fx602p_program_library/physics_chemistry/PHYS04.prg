# PHYS04 - First- and second-order reaction speeds
# Physics/chemistry-4, description see Program Library FX-601P/FX-602P,
# page 93 - 94
# prg code converted from the original document by Claude Code
#
# P1 first-order, P2 second-order reaction, P3..P5 subroutines.
# The comment behind a line is the step number of the program sheet.
# Total 128
# @calculator 602
# @name "PHYS04"
# @mode .20

*** P1
MAC GSBP3                                                   # 2
LBL1 ISZ GSBP4 GSBP5                                        # 6
MR01 / MR03 = ln / MR04 = M+06 HLT                          # 16
MR00 - 4 = x=0 GOTO2 GOTO1                                  # 23
LBL2 M+00 MR00 HLT                                          # 27
MR06 / MR00 = HLT                                           # 32
1/x * 2 ln = HLT                                            # 38

*** P2
MAC GSBP3                                                   # 2
"b?" HLT Min02                                              # 8
LBL1 ISZ GSBP4                                              # 11
MR01 - MR02 = x=0 GOTO2                                     # 17
GSBP5 MR02 * MR03 / MR01 / ( MR02                           # 26
- MR01 + MR03 ) = ln / MR04 / (                             # 37
MR01 - MR02 ) = HLT GOTO1                                   # 44
LBL2 GSBP5 ( MR01 - MR03 ) / MR04 /                         # 54
MR01 / MR03 = HLT GOTO1                                     # 60

*** P3
"a?" HLT Min01                                              # 6

*** P4
"m\AR00?" HLT Min03                                         # 7
"t\AR00?" HLT Min04                                         # 14

*** P5
"K\AR00" PAUSE                                              # 5
