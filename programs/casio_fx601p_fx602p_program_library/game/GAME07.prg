# GAME07 - Search-bug game
# Game-7, description see Program Library FX-601P/FX-602P, page 183 - 186
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 230 (P7, P8, P0 on page 184, P4 on page 186, FX-602P only)
# @calculator 602
# @name "GAME07"
# @mode .20

*** P7
RAN# * MR1F = INT                                           # 5

*** P8
MR07 - 1 = x=0 GOTO1 "Ri/Wr\->\AR08:\AR09" GOTO2            # 9, 16, 18
LBL1 "Wr/Ri\->\AR08:\AR09"                                  # 27, 30
LBL2                                                        # 31

*** P0
Min06 5 Min00 1 M+09 0 Min07                                # 7
LBL2 MR1F MinF IND MR00 x>=F GOTO8 INT -                    # 16
MR06 INT = ABS MinF MR06 FRAC -                             # 24
IND MR00 FRAC =                                             # 28
ABS M+F 0 x=F GOTO3 1 x=F GOTO6                             # 36
. 1 x=F GOTO6                                               # 40
LBL8 DSZ GOTO2 GOTO4                                        # 44
LBL6 MRF Min07 GSBP7 / 2 = FRAC x=0                         # 53
GOTO7 1                                                     # 55
LBL7 Min06 GSBP7 / 2 = FRAC x=0 . 1                         # 65
IND GOTO6                                                   # 67
LBL0 IND M+00 IND M+00                                      # 72
LBL1 IND M-00 MR1F MinF IND MR00 x>=F 1                     # 81
0 IND M-00 IND MR00 ABS IND Min00                           # 89
GSBP8 GOTO5                                                 # 91
LBL3 MR1F IND M+00 1 M-08 "Right\->\AR08:\AR09" GOTO5       # 100, 106, 109
LBL4 "Wrong\->\AR08:\AR09"                                  # 117, 121
LBL5                                                        # 122

*** P4
MAC 1 Min00 1 0 Min1F                                       # 6
LBL1 "m" MR00 Min06 GSBP7 IND                               # 14
Min00 GSBP7 / MR1F = "mw" IND M+00 IND MR00 MinF            # 21, 28
"mwm"                                                       # 33
LBL2 1 M-06 MR06 x=0 GOTO3 IND MR06 x=F                     # 42
GOTO1 GOTO2                                                 # 44
LBL3 MR00 MinF 5 x=F GOTO4 ISZ GOTO1                        # 52
LBL4 5 Min08 "Search Bugs"                                  # 61, 68
