# EENG04 - Design of an active low-pass filter
# Electrical engineering-4, description see Program Library FX-601P/FX-602P,
# page 39 - 40
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 119 (the Japanese edition has 115 steps, without * 1 EXP 6)
# @calculator 602
# @name "EENG04"
# @mode .20

*** P0
LBL1 "fc(Hz) ?" HLT Min01                                   # 9, 13
"Af ?" HLT Min02                                            # 21
"C1(\MUF) ?" HLT EXP 6 +/- Min03                            # 30, 36
1 Min00 GSBP1 PAUSE                                         # 40
2 * PI * MR01 = Min04                                       # 47
2 SQR * MR02 * MR04 * MR03 = 1/x                            # 57
HLT                                                         # 58
GSBP1 PAUSE * MR02 = HLT                                    # 64
GSBP1 PAUSE / ( MR02 + 1 ) = HLT                            # 74
"ANS C2(\MUF)" PAUSE 2 * ( MR02 + 1 )                       # 84, 94
* MR03 * 1 EXP 6 = HLT GOTO1                                # 103

*** P1
"ANS R\AR00(Ohm)" ISZ                                       # 9, 14
