# MECH09 - Design of coil spring
# Mechanics-9, description see Program Library FX-601P/FX-602P, page 83 - 84
# prg code converted from the original document by Claude Code
#
# P1..P6 input of the data, P0, P7, P8 and P9 calculations.
# The comment behind a line is the step number of the program sheet.
# Total 119
# @calculator 602
# @name "MECH09"
# @mode .20

*** P1
Min01                                                       # 1

*** P2
Min02                                                       # 1

*** P3
Min03                                                       # 1

*** P4
Min04                                                       # 1

*** P5
Min05                                                       # 1

*** P6
Min06                                                       # 1

*** P0
MR01 x^y 4 * MR04 / 8 / MR02                                # 9
x^y 3 / MR03                                                # 13
"K=" PAUSE PAUSE = HLT                                      # 21
* MR05                                                      # 23
"P=" PAUSE PAUSE = HLT                                      # 31

*** P7
8 * MR02 x^y 3 * MR03 * MR06                                # 9
/ MR04 / MR05 = x^(1/y) 4                                   # 16
"d=" PAUSE PAUSE = HLT                                      # 24

*** P8
MR01 x^y 4 * MR04 * MR05 / 8 /                              # 10
MR03 / MR06 = x^(1/y) 3                                     # 16
"D=" PAUSE PAUSE = HLT                                      # 24

*** P9
MR01 x^y 4 * MR04 * MR05 / 8 /                              # 10
MR02 x^y 3 / MR06                                           # 15
"Na=" PAUSE PAUSE = HLT                                     # 24
