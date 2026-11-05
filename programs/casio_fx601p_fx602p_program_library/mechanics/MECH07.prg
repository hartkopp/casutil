# MECH07 - Free vibration
# Mechanics-7, description see Program Library FX-601P/FX-602P, page 79 - 80
# prg code converted from the original document by Claude Code
#
# P1..P5 input of the data, P0 calculation of the frequency f.
# The comment behind a line is the step number of the program sheet.
# Total 103
# @calculator 602
# @name "MECH07"
# @mode .20

*** P1
"d=?" HLT Min01                                             # 7

*** P2
"D=?" HLT Min02                                             # 7

*** P3
"N=?" HLT Min03                                             # 7

*** P4
"G=?" HLT Min04                                             # 7

*** P5
"D1=?" HLT Min05                                            # 8
"h=?" HLT Min06                                             # 15
"b=?" HLT Min07                                             # 22

*** P0
MR04 * MR01 x^y 4 / 8 / MR03 /                              # 10
MR02 x^y 3 = Min08                                          # 15
PI * MR05 x^2 * MR06 * MR07 / 4 /                           # 26
9 8 0 = Min09                                               # 31
MR08 / MR09 = SQR / 2 / PI                                  # 40
"f=" PAUSE PAUSE =                                          # 47
