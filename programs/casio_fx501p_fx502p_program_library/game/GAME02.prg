# GAME02 - Artillery game
# Game-2, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Game-2
# prg code converted from the original document by Claude Code
#
# A random field with the distances A, B, C, the wall height D and the
# wind W is created; distance E and wind W are shown alternately (d.ms
# display), C stops with HLT. Input the initial speed and the angle; the
# program shows 0 if the shot hits the wall, the distance beyond or
# before the target otherwise, and 505 ("SOS") for a hit.
# P1..P4 are subroutines.
# FX-501P/FX-502P only, not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 127
# @calculator 502
# @number 552

*** P1
3 10^x =                                                    # 3

*** P2
4 . 9                                                       # 3

*** P3
Min0 MR9 * MR0 / MR8 - GSBP2 * MR0 x^2                      # 11
/ MR8 x^2 = MinF MR5                                        # 17

*** P4
/ 2 =                                                       # 3

*** P0
5 Min0                                                      # 2
LBL1 RAN# RAN# * GSBP1 IND Min0 DSZ GOTO1                   # 11
MR1 / 1 0 - 5 0 M+4 = INT x=0 1 Min1                        # 24
MR5 GSBP4 INT Min5 MR2 + MR3 + Min3                         # 33
LBL2 MR4 = Min4 DMS<- PAUSE x=0 GOTO0                       # 41
MR1 PAUSE x=0 GOTO0 GOTO2                                   # 46
LBL0 HLT Min6 0 HLT Min7 DEG cos * MR6 + MR1 =              # 59
Min8 MR6 * MR7 sin = Min9 MR2 GSBP3                         # 68
x>=F GOTO3                                                  # 70
MR3 GSBP3 x>=F GOTO3                                        # 74
MR8 * MR9 / GSBP2 - MR4 = INT x=0 GOTO4                     # 85
PAUSE GOTO2                                                 # 87
LBL3 0 DMS<- PAUSE GOTO2                                    # 92
LBL4 5 0 5                                                  # 96
