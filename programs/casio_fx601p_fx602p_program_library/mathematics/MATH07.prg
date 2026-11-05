# MATH07 - Complex arithmetics
# Mathematics-7, description see Program Library FX-601P/FX-602P, page 15 - 16
# prg code converted from the original document by Claude Code
#
# P9 converts with P->R as the English sheet and the FX-501P/FX-502P
# version, the Japanese sheet has R->P there.
# The comment behind a line is the step number of the program sheet.
# Total 115
# @calculator 602
# @name "MATH07"
# @mode .20

*** P0
AC                                                          # 1
MAC HLT X<->M01 HLT X<->M02 HLT X<->M03 HLT X<->M04         # 10
MR01 + MR03 M-01 = HLT MR02 + MR04 M-02 = HLT               # 22
MR01 HLT MR02                                               # 25

*** P1
AC                                                          # 1
GSBP8 GSBP7 0 GSBP8 X<->Y M+02                              # 7
X<->Y * MR01 = GSBP9                                        # 12

*** P2
AC                                                          # 1
GSBP8 GSBP7 0 GSBP8 X<->Y M-02                              # 7
X<->Y / MR01 X<->Y = GSBP9                                  # 13

*** P3
Min00 AC GSBP8 GSBP7 MR02 * MR00 = Min02                    # 9
MR01 x^y MR00 = GSBP9                                       # 14

*** P4
Min00 DEG AC GSBP8 GSBP7 MR01 x^(1/y) MR00 =                # 9
Min01 MR02 / MR00 = Min02 3 6 0 / MR00 = Min03              # 22
LBL1 MR03 M+02 MR01 GSBP9 HLT DSZ GOTO1                     # 30

*** P7
Min01 X<->Y Min02                                           # 3

*** P8
HLT R->P 0 HLT =                                            # 5

*** P9
P->R MR02 = HLT X<->Y                                       # 5
