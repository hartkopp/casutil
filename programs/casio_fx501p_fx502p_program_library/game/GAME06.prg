# GAME06 - Last-stone game I
# Game-6, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Game-6
# prg code converted from the original document by Claude Code
#
# P0 starts a game, P1..P3 take 1..3 stones, P4 is the move of the
# calculator. P5 shows the last moves and the stones left in the d.ms
# display. The jumps GOTO3 in P6 and GOTO7 in P4 lead to labels that do
# not exist: the error display signals that the player lost or won
# (the same in the German edition).
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library GAME05,
# with the alpha output "LOSE" and "WIN", same game.
# The comment behind a line is the step number of the program sheet.
# Total 128
# @calculator 502
# @number 556

*** P5
AC MR3 + MR2 / 6 0 +                                        # 8
MR1 / 6 0 x^2 = DMS<-                                       # 15

*** P6
MinF MR2 Min3 MR1 Min2 X<->MF x>=F GOTO1                    # 8
M-1 GSBP5 PAUSE GSBP4 GOTO2                                 # 13
LBL1 GOTO3                                                  # 15
LBL2 DMS<-                                                  # 17

*** P0
AC                                                          # 1
LBL1 RAN# RAN# * 2 10^x + 4 = INT Min1                      # 12
6 0 MinF MR1 x>=F GOTO1 0 Min2 Min3 GSBP5                   # 22

*** P1
1 GSBP6                                                     # 2

*** P2
2 GSBP6                                                     # 2

*** P3
3 GSBP6                                                     # 2

*** P4
MR2 Min3 MR1 Min2 / 4 = Min4 INT Min5                       # 10
MinF 4 x>=F GOTO1                                           # 14
LBL2 RAN# RAN# * 1 0 + 1 = INT MinF                         # 25
LBL3 3 x>=F GOTO4 M-F GOTO3                                 # 31
LBL1 MR5 M-4 MR4 * 4 =                                      # 38
x=0 4 - 1 = MinF + MR5 =                                    # 47
x=0 GOTO5 MRF x=0 GOTO2                                     # 52
LBL4 MRF M-1 GSBP5 GOTO6                                    # 57
LBL5 GOTO7                                                  # 59
LBL6 DMS<-                                                  # 61
