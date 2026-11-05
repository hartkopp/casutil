# MATH01 - Prime factor analysis
# Mathematics-1, description see Program Library FX-601P/FX-602P, page 1 - 2
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 100
# @calculator 602
# @name "MATH01"
# @mode .20

*** P0
Min01 AC "START" GOTO2                                      # 10
LBL1 MR01 / 2 ";\*#" HLT =                                  # 21
Min01 - 1 = x=0 GOTO0                                       # 27
LBL2 MR01 / 2 = FRAC x=0 GOTO1                              # 35
LBL3 3 Min02                                                # 38
LBL4 MR01 SQR MinF 1 M+F                                    # 44
LBL5 MR01 / MR02 x>=F GOTO7 =                               # 51
FRAC x=0 GOTO8                                              # 54
LBL6 2 M+02 GOTO5                                           # 58
LBL8 MR01 / MR02 * MR02 - MR01 =                            # 67
x=0 GOTO9 GOTO6                                             # 70
LBL9 MR01 / MR02 ";\*#" HLT                                 # 80
= Min01 GOTO4                                               # 83
LBL7 MR01 ";\*#" HLT                                        # 91
LBL0 ";\*END"                                               # 99
