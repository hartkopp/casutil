# EENG07 - Impedance of transmission line
# Electrical engineering-7, description see Program Library FX-601P/FX-602P,
# page 45 - 46
# prg code converted from the original document by Claude Code
#
# P1 coaxial line, P2 parallel line, P3 single line above ground,
# P0 data input.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 119
# @calculator 602
# @name "EENG07"
# @mode .20

*** P0
"D(mm) ?" HLT Min01                                         # 8, 11
"d(mm) ?" HLT Min02                                         # 18, 22
"\EXr ?"                                                    # 28
HLT SQR Min03                                               # 31
MR01 / MR02 = Min05                                         # 36
1 3 8 . 0 5 9 8 2 4 Min04                                   # 47

*** P1
LBL1 GSBP0 1 GSBP4                                          # 4
MR05 log * MR04 / MR03 = HLT GOTO1                          # 13

*** P2
LBL1 GSBP0 2 GSBP4                                          # 4
MR05 x^2 - 1 = SQR + MR05 =                                 # 13
log * 2 * MR04 / MR03 = HLT GOTO1                           # 23

*** P3
LBL1 GSBP0 3 GSBP4                                          # 4
MR05 * 4 = log * MR04 / MR03 =                              # 14
HLT GOTO1                                                   # 16

*** P4
Min00 "ANS Z\AR00(Ohm)" PAUSE                               # 9, 15
