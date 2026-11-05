# MATH08 - Vector calculations
# Mathematics-8, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-8
# prg code converted from the original document by Claude Code
#
# P0 input of V1 and V2, P1 V1 + V2, P6 V1 - V2, P2 inner product,
# P3 angle, P4 outer product. Not in the FX-601P/FX-602P library.
# The comment behind a line is the step number of the program sheet.
# Total 108
# @calculator 502
# @number 108

*** P0
MAC                                                         # 1
LBL1 ISZ HLT IND X<->M0 GOTO1                               # 7

*** P1
MR1 + MR4 = HLT MR2 + MR5 = HLT MR3 +                       # 12
MR6 =                                                       # 14

*** P6
MR1 - MR4 = HLT MR2 - MR5 = HLT MR3 -                       # 12
MR6 =                                                       # 14

*** P2
MR1 * MR4 + MR2 * MR5 + MR3 * MR6 =                         # 12

*** P3
GSBP2 / ( MR1 x^2 + MR2 x^2 + MR3 x^2 )                     # 12
SQR / ( MR4 x^2 + MR5 x^2 + MR6 x^2 )                       # 24
SQR = DEG cos-1 DMS<-                                       # 29

*** P4
MR2 * MR6 - MR3 * MR5 = HLT                                 # 9
MR3 * MR4 - MR1 * MR6 = HLT                                 # 18
MR1 * MR5 - MR2 * MR4 =                                     # 26
