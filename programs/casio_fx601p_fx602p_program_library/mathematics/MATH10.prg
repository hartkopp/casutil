# MATH10 - 3 variable linear equations
# Mathematics-10, description see Program Library FX-601P/FX-602P, page 21 - 22
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 175 (FX-602P only)
# @calculator 602
# @name "MATH10"
# @mode .20

*** P0
MAC 1 2 Min00 AC                                            # 5
LBL1 1 M+F                                                  # 8
"a\ARF?" HLT IND                                            # 15
Min00 DSZ                                                   # 17
"b\ARF?" HLT IND                                            # 24
Min00 DSZ                                                   # 26
"c\ARF?" HLT IND                                            # 33
Min00 DSZ                                                   # 35
"d\ARF?" HLT IND                                            # 42
Min00 DSZ GOTO1                                             # 45
1 3 Min13 GSBP2 4 Min17 1 GSBP5 GSBP2                       # 54
1 Min17 3 GSBP5 3 Min17 4 GSBP5                             # 62
GSBP2 MR15 / MR14 = Min17 "x=#" HLT                         # 71, 74
MR16 / MR14 = Min18 "y=#" HLT                               # 83, 85
( MR11 - MR17 * MR12 - MR18 * MR09                          # 95
) / MR10 = "z=#"                                            # 104

*** P1
MR12 * MR07 * MR02 + MR11 * MR06                            # 9
* MR04 + MR10 * MR08 * MR03 - ( MR10                        # 20
* MR07 * MR04 + MR06 * MR03 * MR12 +                        # 31
MR02 * MR11 * MR08 ) = IND Min13                            # 40

*** P2
1 M+13 GSBP1                                                # 3

*** P3
IND MR17 MinF IND MR18 IND Min17                            # 7
MRF IND Min18                                               # 10

*** P4
LBL1 4 M+17 M+18 GSBP3 DSZ GOTO1                            # 7

*** P5
Min18 2 Min00 GSBP3 GSBP4                                   # 5
