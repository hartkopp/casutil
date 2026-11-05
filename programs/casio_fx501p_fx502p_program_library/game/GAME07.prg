# GAME07 - Last-stone game II
# Game-7-1 and 7-2, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheets Game-7-1 (P5..P8) and 7-2 (P0..P4)
# prg code converted from the original document by Claude Code
#
# P0 starts a game with three heaps, P1..P3 take stones from heap 1..3
# (the number is entered first), P4 is the move of the calculator.
# P5 shows the heaps in the d.ms display; when all heaps are empty the
# jump GOTO6 to a label that does not exist shows the error display as
# end of the game (the same in the German edition). P6..P8 are
# subroutines.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library GAME06,
# with alpha output, same game, M11..M13 there instead of M.1..M.3
# (FX-602P only there).
# The comment behind a line is the step number of the program sheet.
# Total 217
# @calculator 502
# @number 557

*** P5
MR1 x>=0 GOTO1 GOTO2                                        # 4
LBL1 + MR2 x>=0 GOTO3 GOTO2                                 # 10
LBL3 / 6 0 + MR3 x>=0 GOTO4 GOTO2                           # 19
LBL4 / 3 6 0 0 = x=0 GOTO2 GOTO5                            # 29
LBL2 GOTO6                                                  # 31
LBL5 DMS<-                                                  # 33

*** P6
0 Min8 8 MinF 3 Min0                                        # 6
LBL1 IND MR0 x>=F GOTO2 GOTO3                               # 12
LBL2 MR0 + 3 = Min.2 8 IND M-0 1 M+8                        # 23
LBL3 DSZ GOTO1                                              # 26

*** P7
3 Min0                                                      # 2
LBL1 IND MR0 IND M+0 DSZ GOTO1                              # 9

*** P8
0 Min0 2 MinF                                               # 4
MR4 x>=F 5 M+0                                              # 8
MR5 x>=F 5 M+0                                              # 12
MR6 x>=F 5 M+0                                              # 16
IND MR.2 x>=F 5 M-0 3 MinF                                  # 23
MR0 x>=F GOTO3 IND GOTO0                                    # 28
LBL1 IND MR.2 Min7 GOTO3                                    # 33
LBL0                                                        # 34
LBL2 IND MR.2 - 1 = x=0 1 Min7                              # 43
LBL3 MR7                                                    # 45

*** P0
AC 3 Min0 RAN# RAN#                                         # 5
LBL1 * 1 0 + 6 = Min4 INT IND Min0 MR4 FRAC                 # 18
DSZ GOTO1 GSBP5                                             # 21

*** P1
M-1 GSBP5                                                   # 2

*** P2
M-2 GSBP5                                                   # 2

*** P3
M-3 GSBP5                                                   # 2

*** P4
MR1 Min4 MR2 Min5 MR3 Min6                                  # 6
0 Min7 Min.3 8 Min.1 Min9                                   # 12
LBL5 GSBP6 IND GOTO8                                        # 16
LBL3 MR.1 M+7                                               # 19
LBL0                                                        # 20
LBL2 2 M-9 MR9 x=0 GOTO6                                    # 26
GSBP7 MR.1 / 2 = Min.1 GOTO5                                # 33
LBL1 MR.3 x=0 GOTO7                                         # 37
MinF MR.2 x=F GOTO3                                         # 41
MR.1 M-7 GOTO2                                              # 44
LBL7 MR.2 Min.3 GOTO3                                       # 48
LBL6 MR7 x=0 1 Min7 MR.3 x=0 GOTO9 Min.2                    # 57
LBL9 GSBP8 IND M-.2                                         # 61
MR4 Min1 MR5 Min2 MR6 Min3 GSBP5                            # 68
