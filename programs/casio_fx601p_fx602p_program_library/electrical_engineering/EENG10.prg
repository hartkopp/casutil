# EENG10 - Distributed constant circuit
# Electrical engineering-10, description see Program Library FX-601P/FX-602P,
# page 51 - 52
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 224 (FX-602P only)
# @calculator 602
# @name "EENG10"
# @mode .56

*** P0
GSBP3 "R(Ohm/km)" HLT Min01                                 # 8, 14
"L(mH/km)" HLT EXP 3 +/- Min02                              # 22, 29
"G(\MUMho/km)" HLT / 6 10^x =                               # 37, 46
Min03                                                       # 47
"C(\MUF/km)" HLT EXP 6 +/- Min04 DEG                        # 55, 63
LBL1 "f(Hz)" HLT                                            # 72
* 2 * PI = Min05                                            # 78
"ANSWERS"                                                   # 87
MR01 x^2 + MR05 x^2 * MR02                                  # 94
x^2 = SQR Min06                                             # 98
MR03 x^2 + MR05 x^2 * MR04                                  # 105
x^2 = SQR Min07                                             # 109
MR05 * MR02 / MR01 = tan-1                                  # 116
Min08                                                       # 117
MR03 x=0 GOTO2 GOTO3                                        # 121
LBL2 9 0 Min09 GOTO4                                        # 126
LBL3 MR05 * MR04 / MR03 = tan-1                             # 134
Min09                                                       # 135
LBL4 "Z0(Ohm)"                                              # 145
PAUSE MR06 / MR07 = SQR HLT                                 # 152
"Phase" PAUSE                                               # 160
( MR08 - MR09 ) / 2 = HLT                                   # 169
"Alpha" PAUSE                                               # 177
GSBP1 cos GSBP2 HLT                                         # 181
"Beta" PAUSE                                                # 188
GSBP1 sin GSBP2 HLT                                         # 192
GSBP3 GOTO1                                                 # 194

*** P1
( MR08 + MR09 ) / 2 =                                       # 8

*** P2
* ( MR06 * MR07 ) SQR =                                     # 8

*** P3
"INPUT !" PAUSE                                             # 10
