# MECH04 - Simple beam under distributed load
# Mechanics-4, description see Program Library FX-601P/FX-602P, page 73 - 74
# prg code converted from the original document by Claude Code
#
# P1 leaves two parentheses open, which P0 closes.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 113
# @calculator 602
# @name "MECH04"
# @mode .20

*** P0
HLT Min01 HLT Min02 HLT Min03 HLT Min04 DEG                 # 9
LBL1 HLT Min05 MR04 / 2 4 / MR01 / MR02 =                   # 21
+/- Min06                                                   # 23
MR03 x^y 3 = Min07                                          # 28
MR05 * GSBP1 - 2 * MR03 ) )                                 # 37
"y=" PAUSE PAUSE = HLT                                      # 38, 45
GSBP1 * 4 - 6 * MR03 ) ) =                                  # 55
"s=" PAUSE PAUSE tan-1 HLT                                  # 56, 63
MR04 * MR05 / 2 * ( MR05 - MR03 )                           # 74
"M=" PAUSE PAUSE = +/- HLT                                  # 83
MR04 * ( MR03 / 2 - MR05 )                                  # 92
"Ws=" PAUSE PAUSE = GOTO1                                   # 101

*** P1
MR06 * ( MR07 + MR05 x^2 * ( MR05                           # 10
