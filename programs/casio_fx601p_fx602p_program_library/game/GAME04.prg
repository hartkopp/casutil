# GAME04 - Hit-and-blow game
# Game-4, description see Program Library FX-601P/FX-602P, page 175 - 176
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 123
# @calculator 602
# @name "GAME04"
# @mode .20

*** P5
* 1 0 =                                                     # 4

*** P4
MAC 1 Min00                                                 # 3
LBL1 RAN# RAN# GSBP5 INT MinF IND Min00                     # 11
MR00 Min05                                                  # 13
LBL2 1 M-05 MR05 x=0 GOTO3                                  # 19
IND MR05 x=F GOTO1 GOTO2                                    # 24
LBL3 4 MinF MR00 x=F GOTO4 ISZ GOTO1                        # 32
LBL4 IND MR00 * ( MR00 - 1 ) 10^x +                         # 43
DSZ GOTO4 X<->M08 AC "?:?:?:?"                              # 51, 56

*** P0
Min07 3 6 0 0 1/x M+09 MR07 / 4                             # 10
Min07 10^x = Min06 0 Min05                                  # 16
LBL1 4 Min00 MR06 GSBP5 Min06 INT MinF                      # 24
M-06                                                        # 25
LBL2 IND MR00 x=F GOTO4 DSZ GOTO2                           # 32
LBL3 1 M-07 MR07 x=0 GOTO6 GOTO1                            # 39
LBL4 MR07 - MR00 = x=0 GOTO5                                # 46
6 0 1/x M+05 GOTO3                                          # 51
LBL5 1 M+05 GOTO3                                           # 55
LBL6 MR09 M+05 MR05 DMS<-                                   # 60
