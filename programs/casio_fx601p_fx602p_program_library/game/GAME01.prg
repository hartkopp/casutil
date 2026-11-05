# GAME01 - Secret number game
# Game-1, description see Program Library FX-601P/FX-602P, page 169 - 170
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 78
# @calculator 602
# @name "GAME01"
# @mode .20

*** P0
"GAME START"                                # 12
PAUSE MAC AC 5 0 Min08 Min02 RAN# RAN#      # 21
* 2 10^x = INT Min06 - MR08 = x>=0          # 31
GOTO1 GOTO2                                 # 33
LBL1 Min06                                  # 35
LBL2 MinF "\AR01 < X > \AR02" PAUSE x=F     # 43, 50
GOTO2                                       # 51
Min08 1 M+09 MR08 - MR06 = x=0 GOTO4        # 60
x>=0 GOTO3 MR08 Min01 GOTO2                 # 65
LBL3 MR08 Min02 GOTO2                       # 69
LBL4 "HIT" PAUSE MR09                       # 77
