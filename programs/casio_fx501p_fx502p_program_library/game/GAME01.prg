# GAME01 - Secret number game
# Game-1, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Game-1
# prg code converted from the original document by Claude Code
#
# The range is shown as lower and upper limit in the d.ms display
# (M1 + M2 / 3600 with DMS<-), the number of tries at the end.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library GAME01,
# with alpha output "< X >" and "HIT", same game.
# The comment behind a line is the step number of the program sheet.
# Total 60
# @calculator 502
# @number 551

*** P0
MAC AC 5 0 MinF Min2 RAN# RAN# * 2 10^x =                   # 12
INT x>=F GOTO1 GOTO2                                        # 16
LBL1 - MRF =                                                # 20
LBL2 Min8                                                   # 22
LBL3 MR1 + MR2 / 3 6 0 0 = Min6                             # 33
LBL4 MR6 DMS<- PAUSE MinF FRAC x=0 GOTO5 GOTO4              # 42
LBL5 1 M+9 MR8 x=F GOTO7                                    # 48
x>=F GOTO6                                                  # 50
MRF Min2 GOTO3                                              # 53
LBL6 MRF Min1 GOTO3                                         # 57
LBL7 MR9                                                    # 59
