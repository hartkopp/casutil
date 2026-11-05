# MATH09 - 4-by-4 determinant
# Mathematics-9, description see Program Library FX-601P/FX-602P, page 19 - 20
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 159 (FX-602P only)
# @calculator 602
# @name "MATH09"
# @mode .20

*** P0
MAC                                                         # 1
LBL1 1 M+F                                                  # 4
LBL2 1 0 M+F ISZ "a\ARF?" HLT IND Min00 4 0 x>=F GOTO2 GOTO3   # 13, 22
LBL3 4 0 M-F 4 x=F GOTO4 GOTO1                              # 30
LBL4 0 Min19                                                # 33
MR16 * MR11 - MR12 * MR15 = Min17                           # 42
MR06 * MR01 - MR02 * MR05 = Min18                           # 51
GSBP1                                                       # 52
MR08 * MR15 - MR16 * MR07 = Min17                           # 61
MR10 * MR01 - MR02 * MR09 = Min18                           # 70
GSBP1                                                       # 71
MR16 * MR03 - MR04 * MR15 = Min17                           # 80
MR10 * MR05 - MR06 * MR09 = Min18                           # 89
GSBP1                                                       # 90
MR12 * MR07 - MR08 * MR11 = Min17                           # 99
MR14 * MR01 - MR02 * MR13 = Min18                           # 108
GSBP1                                                       # 109
MR04 * MR11 - MR12 * MR03 = Min17                           # 118
MR14 * MR05 - MR06 * MR13 = Min18                           # 127
GSBP1                                                       # 128
MR08 * MR03 - MR04 * MR07 = Min17                           # 137
MR14 * MR09 - MR10 * MR13 = Min18                           # 146
GSBP1                                                       # 147
"A=\AR19"                                                   # 152

*** P1
MR17 * MR18 = M+19                                          # 5
