# MATH08 - Transformation of coordinates
# Mathematics-8, description see Program Library FX-601P/FX-602P, page 17 - 18
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 95
# @calculator 602
# @name "MATH08"
# @mode .20

*** P0
MAC                                                         # 1
LBL1 MR01 "x=#?" HLT                                        # 10
Min01                                                       # 11
MR02 "y=#?" HLT                                             # 19
Min02                                                       # 20
MR03 "x0=#?" HLT                                            # 29
Min03                                                       # 30
MR04 "y0=#?" HLT                                            # 39
Min04                                                       # 40
MR05 "a=#?" HLT                                             # 48
Min05                                                       # 49
MR01 - MR03 = Min06 MR02 - MR04 =                           # 58
Min07 MR06 * MR05 cos + MR07 * MR05 sin                     # 68
= "x'=#" HLT                                                # 76
MR07 * MR05 cos - MR06 * MR05 sin =                         # 86
"y'=#" HLT GOTO1                                            # 94
