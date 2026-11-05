# STAT02 - 6-month moving average
# Statistics-2, description see Program Library FX-601P/FX-602P, page 99 - 100
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 56
# @calculator 602
# @name "STAT02"
# @mode .20

*** P0
MAC 6 Min00 MinF 1 Min09                                    # 6
LBL1 "y\AR09" HLT                                           # 12
IND Min00 M+07 1 M+09 DSZ GOTO1                             # 19
7 M-09                                                      # 21
LBL2 MR07 / 6 = Min08 MR06 M-07 5 Min00                     # 31
LBL3 IND MR00 IND MinF 1 M-F                                # 38
DSZ GOTO3                                                   # 40
6 MinF MR08 "Y\AR09=#" HLT Min01 M+07 1 M+09 GOTO2          # 48, 55
