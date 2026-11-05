# GAME08 - Search-bug game
# Game-8, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Game-8
# prg code converted from the original document by Claude Code
#
# P4 hides the bugs, P0 evaluates a guess; the result, the bugs left
# and the number of tries are shown in the d.ms display. P7 and P8 are
# subroutines, P8 gives the field size 10. M8 holds 10 times the number
# of bugs left, so it fits into the seconds of the d.ms display.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library GAME07,
# with alpha output and the field size in M1F, same game (FX-602P only
# there).
# The comment behind a line is the step number of the program sheet.
# Total 179
# @calculator 502
# @number 558

*** P8
1 0                                                         # 2

*** P7
RAN# * GSBP8 = INT                                          # 5

*** P0
Min6 5 Min0 0 Min7                                          # 5
LBL2 GSBP8 MinF IND MR0 x>=F GOTO8 INT - MR6 INT            # 16
= ABS MinF MR6 FRAC - IND MR0 FRAC =                        # 26
ABS M+F 0 x=F GOTO3 1 x=F GOTO6 . 1 x=F GOTO6               # 38
LBL8 DSZ GOTO2 GOTO4                                        # 42
LBL6 MRF Min7 GSBP7 / 2 = FRAC x=0 GOTO7 1                  # 53
LBL7 Min6 GSBP7 / 2 = FRAC x=0 . 1 IND GOTO6                # 65
LBL0 IND M+0 IND M+0                                        # 70
LBL1 IND M-0 GSBP8 MinF IND MR0 x>=F 1 0 IND                # 81
M-0 IND MR0 ABS IND Min0 GOTO5                              # 88
LBL3 MRF Min7 GSBP8 IND M+0 M-8 GOTO5                       # 96
LBL4 2 . 2 Min7                                             # 101
LBL5 MR7 FRAC / 6 + MR7 INT = Min7                          # 111
MR8 / 3 6 0 0 0 = M+7 1 M+9 MR9 PAUSE                       # 124
MR7 DMS<-                                                   # 126

*** P4
MAC 1 Min0                                                  # 3
LBL1 MR0 Min6 GSBP7 IND Min0 GSBP7 / GSBP8 =                # 13
IND M+0 IND MR0 MinF                                        # 18
LBL2 1 M-6 MR6 x=0 GOTO3 IND MR6 x=F GOTO1 GOTO2            # 29
LBL3 MR0 MinF 5 x=F GOTO4 ISZ GOTO1                         # 37
LBL4 5 0 Min8 AC                                            # 42
