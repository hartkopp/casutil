# EENG05 - Design of an active high-pass filter
# Electrical engineering-5, description see Program Library FX-601P/FX-602P,
# page 41 - 42
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 119
# @calculator 602
# @name "EENG05"
# @mode .20

*** P0
LBL1 "fc(Hz) ?" HLT Min01                                   # 9, 13
"H0 ?" HLT Min02                                            # 21
"C(\MUF) ?" HLT EXP 6 +/- Min03                             # 29, 35
"a ?" HLT Min04                                             # 42
1 Min00 GSBP1 PAUSE                                         # 46
MR01 * 2 * PI = Min01                                       # 53
( 2 * MR02 + 1 ) / MR04 / MR01                              # 64
/ MR03 = HLT                                                # 68
GSBP1 PAUSE MR04 / MR01 / MR03 / (                          # 77
2 + MR02 1/x ) = HLT                                        # 84
"ANS C1(\MUF)" PAUSE                                        # 94, 97
MR03 / MR02 = HLT GOTO1                                     # 103

*** P1
"ANS R\AR00(Ohm)" ISZ                                       # 9, 14
