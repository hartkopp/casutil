# GAME05 - Hit-and-blow game
# Game-5, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Game-5
# prg code converted from the original document by Claude Code
#
# P9 creates a secret number of four different digits, P0 evaluates a
# guess: hits and blows are shown in the d.ms display together with the
# number of tries. P5 is a subroutine.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library GAME04,
# with the alpha output "?:?:?:?", same game; there P4 creates the
# number, here P9.
# The comment behind a line is the step number of the program sheet.
# Total 114
# @calculator 502
# @number 555

*** P5
* 1 0 =                                                     # 4

*** P9
MAC 1 Min0                                                  # 3
LBL1 RAN# RAN# GSBP5 INT MinF IND Min0 MR0                  # 12
Min5                                                        # 13
LBL2 1 M-5 MR5 x=0 GOTO3                                    # 19
IND MR5 x=F GOTO1 GOTO2                                     # 24
LBL3 4 MinF MR0 x=F GOTO4 ISZ GOTO1                         # 32
LBL4 IND MR0 * ( MR0 - 1 ) 10^x + DSZ                       # 44
GOTO4 X<->M8 AC                                             # 47

*** P0
Min7 3 6 0 0 1/x M+9 MR7 / 4 Min7 10^x                      # 12
= Min6 0 Min5                                               # 16
LBL1 4 Min0 MR6 GSBP5 Min6 INT MinF M-6                     # 25
LBL2 IND MR0 x=F GOTO4 DSZ GOTO2                            # 32
LBL3 1 M-7 MR7 x=0 GOTO6 GOTO1                              # 39
LBL4 MR7 - MR0 = x=0 GOTO5                                  # 46
6 0 1/x M+5 GOTO3                                           # 51
LBL5 1 M+5 GOTO3                                            # 55
LBL6 MR9 M+5 MR5 DMS<-                                      # 60
