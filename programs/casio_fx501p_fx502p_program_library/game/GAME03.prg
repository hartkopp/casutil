# GAME03 - Gopher game
# Game-3, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Game-3
# prg code converted from the original document by Claude Code
#
# P0, P1 and P2 start the game variants of the sheet, P5..P9 are
# subroutines.
# The position and the counter are shown as d.ms (P8).
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library GAME02,
# with alpha output instead of the d.ms display, same game.
# The comment behind a line is the step number of the program sheet.
# Total 120
# @calculator 502
# @number 553

*** P9
RAN# * MR8 = INT                                            # 5

*** P8
+ MR0 / 3 6 0 0 = DMS<-                                     # 9

*** P7
LBL1 - 4 = x>=F GOTO1                                       # 6

*** P6
MAC 1 0 Min0 Min8                                           # 5

*** P5
LBL1 GSBP9 Min1 / 4 = FRAC * 4 = INT Min2                   # 12
MR1 GSBP8 PAUSE M-2 MR2 x=0 GOTO3                           # 19
LBL2 DSZ GOTO1 GOTO4                                        # 23
LBL3 1 M+9 GOTO2                                            # 27
LBL4 MR9                                                    # 29

*** P0
GSBP6 4 MinF                                                # 3
LBL1 GSBP9 x>=F GSBP7 x=0 GOTO1 Min1                        # 10
LBL2 GSBP9 x>=F GSBP7 x=0 GOTO2                             # 16
Min2 / 6 0 + MR1 GSBP8 PAUSE Min7                           # 25
LBL3 ( MR1 - 1 ) * 3 + MR2 - MR7 = x=0 GOTO6                # 40
LBL5 DSZ GOTO1 GOTO7                                        # 44
LBL6 1 M+9 GOTO5                                            # 48
LBL7 MR9                                                    # 50

*** P1
GSBP6 GSBP5                                                 # 2

*** P2
GSBP6 1 0 0 Min8 GSBP5                                      # 6
