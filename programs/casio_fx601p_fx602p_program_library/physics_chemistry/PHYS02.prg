# PHYS02 - Parabolic movement
# Physics/chemistry-2, description see Program Library FX-601P/FX-602P,
# page 89 - 90
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 82
# @calculator 602
# @name "PHYS02"
# @mode .20

*** P0
DEG                                                         # 1
"V0=?" HLT Min01                                            # 9
"a=?" HLT Min02                                             # 16
"h=?" HLT Min03                                             # 23
"dt=?" HLT Min04                                            # 31
Min05                                                       # 32
LBL1 "t=" GSBP1 MR05 HLT                                    # 40
"x=" GSBP1 MR01 * MR02 cos                                  # 49
* MR05 = HLT                                                # 53
"y=" GSBP1 MR01 * MR02 sin                                  # 62
* MR05 - 4 . 9 * MR05 x^2 + MR03                            # 73
= HLT                                                       # 75
MR04 M+05 GOTO1                                             # 78

*** P1
PAUSE PAUSE                                                 # 2
