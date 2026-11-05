# MATH12 - Cubic equation
# Mathematics-12, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-12
# prg code converted from the original document by Claude Code
#
# Solution of a x^3 + b x^2 + c x + d = 0 by the Cardano formula.
# Not in the FX-601P/FX-602P library.
# The comment behind a line is the step number of the program sheet.
# Total 206 (FX-502P only)
# @calculator 502
# @number 112

*** P0
LBL1 HLT Min1 HLT Min2 HLT Min3 HLT Min4                    # 9
MR3 / MR1 / 3 - MR2 x^2 / 9 / MR1                           # 21
x^2 = Min5 2 * MR2 x^2 * MR2 / 2 7                          # 33
/ MR1 x^2 / MR1 - MR2 * MR3 / 3 /                           # 45
MR1 x^2 + MR4 / MR1 = Min6 MR6 x^2 +                        # 56
4 * MR5 x^2 * MR5 = Min7 x>=0 GOTO2 GOTO9                   # 67
LBL2 ( MR6 + GSBP4 x>=0 GOTO3 GSBP2 Min8 GOTO4              # 77
LBL3 GSBP1 Min8                                             # 80
LBL4 ( MR6 - GSBP4 x>=0 GOTO5 GSBP2 Min9 GOTO6              # 90
LBL5 GSBP1 Min9                                             # 93
LBL6 MR7 x=0 GOTO7 GOTO8                                    # 98
LBL7 2 HLT GSBP3 GOTO1                                      # 103
LBL8 1 HLT GSBP3 HLT 3 SQR * ( MR8 - MR9 ) / 2              # 118
= GOTO1                                                     # 120
LBL9 MR5 +/- SQR MinF MR6 / 2 / MRF x^y 3 =                 # 133
DEG cos-1 / 3 = Min8 0 Min9 3 Min0                          # 143
LBL0 HLT 1 2 0 M+9 2 +/- * MRF * ( MR8 + MR9                # 158
) cos GSBP5 DSZ GOTO0 GOTO1                                 # 164

*** P1
MR0 x^(1/y) 3 =                                             # 4

*** P2
MR0 +/- x^(1/y) 3 = +/-                                     # 6

*** P3
MR8 + MR9 = MinF +/- GSBP5 HLT MRF / 2                      # 11
GSBP5                                                       # 12

*** P4
MR7 SQR ) / 2 = Min0                                        # 7

*** P5
- MR2 / 3 / MR1 =                                           # 7
