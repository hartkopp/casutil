# GAME02 - Gopher game
# Game-2, description see Program Library FX-601P/FX-602P, page 171 - 172
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 119
# @calculator 602
# @name "GAME02"
# @mode .20

*** P9
RAN# * MR08 = INT                                   # 5

*** P7
LBL1 - 4 = x>=F GOTO1                               # 6

*** P6
MAC 1 0 Min00 Min08                                 # 5

*** P5
LBL1 GSBP9 Min01 / 4 = FRAC * 4 = INT               # 11
Min02                                               # 12
9 = "\AR01 :\AR00" PAUSE M-02 MR02 x=0 GOTO3        # 19, 25
LBL2 DSZ GOTO1 GOTO4                                # 29
LBL3 1 M+09 GOTO2                                   # 33
LBL4 MR09                                           # 35

*** P0
GSBP6 4 MinF                                        # 3
LBL1 GSBP9 x>=F GSBP7 x=0 GOTO1 Min01               # 10
LBL2 GSBP9 x>=F GSBP7 x=0 GOTO2 Min02               # 17
AC "\AR01,\AR02 :\AR00" PAUSE Min07                 # 24, 28
LBL3 ( MR01 - 1 ) * 3 + MR02 - MR07 =               # 41
x=0 GOTO6                                           # 43
LBL5 DSZ GOTO1 GOTO7                                # 47
LBL6 1 M+09 GOTO5                                   # 51
LBL7 MR09                                           # 53

*** P1
GSBP6 GSBP5                                         # 2

*** P2
GSBP6 1 0 0 Min08 GSBP5                             # 6
