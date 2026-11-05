# MECH13 - Length of belt
# Mechanics-13, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mechanics-13
# prg code converted from the original document by Claude Code
#
# P0: input d1, d2 and D repeatedly; output length l1 of the open belt
# and l2 of the crossed belt, 0 if (d1 + d2) / 2 > D. P1 and P2 are
# subroutines. FX-501P/FX-502P only, not in the FX-601P/FX-602P program
# library.
# The comment behind a line is the step number of the program sheet.
# Total 82
# @calculator 502
# @number 213

*** P1
PI / 2 * MR4 + MR6 * MR7 + MR3                              # 11
* MR6 cos =                                                 # 15

*** P2
/ MR3 = sin-1 Min6 GSBP1                                    # 6

*** P0
RAD                                                         # 1
LBL0 HLT MinF 0 HLT Min2 x>=F GOTO1 Min1 MRF                # 11
Min2 GOTO2                                                  # 13
LBL1 MRF Min1                                               # 16
LBL2 0 HLT MinF * 2 = Min3                                  # 24
MR1 + MR2 = Min4 MR2 - MR1 =                                # 33
Min5 x>=0 GOTO3 GOTO5                                       # 37
LBL3 MR4 / 2 = x>=F GOTO5                                   # 44
LBL4 MR5 Min7 GSBP2 HLT                                     # 49
MR4 Min7 GSBP2 GOTO0                                        # 53
LBL5 x=F GOTO4 0 GOTO0                                      # 58
