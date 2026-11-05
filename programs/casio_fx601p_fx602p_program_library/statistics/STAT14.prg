# STAT14 - t-test
# Statistics-14, description see Program Library FX-601P/FX-602P, page 123 - 124
# prg code converted from the original document by Claude Code
#
# P0, P1 paired data, P2..P4 two samples.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 143
# @calculator 602
# @name "STAT14"
# @mode .20

*** P0
MAC                                                         # 1
LBL1 MR09 + 1 = "x#" HLT                                    # 11
Min01 MR09 + 1 = "y#"                                       # 20
HLT Min02 MR01 - MR02 = xD GOTO1                            # 28

*** P1
MR09 - 1 = "p=#" HLT                                        # 10
SQR * xbar / sdn = "t=#"                                    # 19, 21

*** P2
MAC                                                         # 1
LBL1 MR09 + 1 = "x#" HLT xD                                 # 12
GOTO1                                                       # 13

*** P3
MR09 Min01 MR07 Min02 xbar Min03 SAC                        # 7
LBL1 MR09 + 1 = "y#" HLT xD                                 # 18
GOTO1                                                       # 19

*** P4
Min04 MR01 + MR09 - 2 = Min05                               # 8
"p=#" HLT                                                   # 14
( MR03 - xbar - MR04 ) / ( MR01                             # 24
1/x + MR09 1/x ) SQR / ( ( MR02                             # 34
- MR01 * MR03 x^2 + MR07 - MR09 *                           # 44
xbar x^2 ) / MR05 ) SQR =                                   # 52
"t=#"                                                       # 57
