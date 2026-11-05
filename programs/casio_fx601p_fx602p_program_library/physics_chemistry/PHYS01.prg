# PHYS01 - Simple pendulum
# Physics/chemistry-1, description see Program Library FX-601P/FX-602P,
# page 87 - 88
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 93
# @calculator 602
# @name "PHYS01"
# @mode .20

*** P0
0 Min07 "l=?" HLT Min01                                     # 9
"x0=?" HLT Min02                                            # 17
MR01 / 9 8 0 = SQR * 2 * PI = Min03                         # 30
"T=" PAUSE PAUSE MR03                                       # 37
HLT                                                         # 38
"t(int)=?" HLT Min04 DEG 1 Min08                            # 46, 53
LBL1 "t\AR08=" PAUSE                                        # 60
PAUSE MR04 M+07 MR07 PAUSE                                  # 65
"x\AR08=" PAUSE                                             # 71
PAUSE MR02 * ( ( MR07 / MR03 )                              # 80
FRAC * 3 6 0 ) cos = HLT                                    # 89
1 M+08 GOTO1                                                # 92
