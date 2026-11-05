# EENG09 - Minimum loss matching
# Electrical engineering-9, description see Program Library FX-601P/FX-602P,
# page 49 - 50
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 92
# @calculator 602
# @name "EENG09"
# @mode .20

*** P0
LBL1 AC Min00                                               # 3
GSBP1 GSBP1 / MR01 = Min03                                  # 9
1 - MR03 = SQR Min04                                        # 15
1 Min00                                                     # 17
GSBP2 MR04 * MR01 = HLT                                     # 23
GSBP2 MR02 / MR04 = HLT                                     # 29
"Lmin(dB)" PAUSE                                            # 37, 40
MR03 1/x - 1 = SQR                                          # 46
+ MR03 1/x SQR = log                                        # 52
* 2 0 = HLT GOTO1                                           # 58

*** P1
"INPUT Z\AR00 ?" HLT ISZ IND Min00                          # 10, 16

*** P2
"ANS R\AR00(Ohm)" PAUSE ISZ                                 # 9, 15
