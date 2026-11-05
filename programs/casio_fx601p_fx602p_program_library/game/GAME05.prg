# GAME05 - Last-stone game I
# Game-5, description see Program Library FX-601P/FX-602P, page 177 - 178
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 126
# @calculator 602
# @name "GAME05"
# @mode .20

*** P5
"\AR03/\AR02:\AR01"                                         # 6, 7

*** P6
MinF MR02 Min03 MR01 Min02 X<->MF x>=F                      # 7
GOTO1 M-01 GSBP5 PAUSE GSBP4 GOTO2                          # 13
LBL1 "LOSE"                                                 # 20
LBL2                                                        # 21

*** P0
LBL1 RAN# RAN# * 2 10^x + 4 = INT Min01                     # 11
6 0 MinF MR01 x>=F GOTO1 0 Min02 Min03                      # 20
GSBP5                                                       # 21

*** P1
1 GSBP6                                                     # 2

*** P2
2 GSBP6                                                     # 2

*** P3
3 GSBP6                                                     # 2

*** P4
MR02 Min03 MR01 Min02 / 4 = Min04 INT                       # 9
Min05 MinF 4 x>=F GOTO1                                     # 14
LBL2 RAN# RAN# * 1 0 + 1 = INT MinF                         # 25
LBL3 3 x>=F GOTO4 M-F GOTO3                                 # 31
LBL1 MR05 M-04 MR04 * 4 = x=0 4 - 1 =                       # 43
MinF + MR05 = x=0 GOTO5 MRF x=0                             # 51
GOTO2                                                       # 52
LBL4 MRF M-01 GSBP5 GOTO6                                   # 57
LBL5 "WIN"                                                  # 63
LBL6                                                        # 64
