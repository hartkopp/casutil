# MED02 - Surface area of a human body
# Medicine-2, description see Program Library FX-601P/FX-602P, page 137 - 138
# prg code converted from the original document by Claude Code
#
# BSA(D) by DuBois if it is at least 0.6 (M F), otherwise BSA(B) by Boyd.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 127
# @calculator 602
# @name "MED02"
# @mode .20

*** P0
LBL3 GSBP1 ";h\->Cm" HLT Min01                              # 7, 11
GSBP1 ";W\->kg" HLT Min02                                   # 18, 21
* 3 10^x = Min03 . 6 MinF                                   # 29
7 1 . 8 4 EXP 4 +/- * MR01 x^y                              # 40
. 7 2 5 * MR02 x^y . 4 2 5                                  # 51
= Min04                                                     # 53
x>=F GOTO2                                                  # 55
GOTO1                                                       # 56
LBL2 "BSA(D)=" PAUSE                                        # 67
MR04 HLT GOTO3                                              # 70
LBL1 "BSA(B)=" PAUSE                                        # 81
. 7 2 8 5 - . 0 1 8 8 * MR03                                # 94
log = Min05 3 . 2 0 7 EXP 4 +/- *                           # 106
MR03 x^y MR05 * MR01 x^y . 3 =                              # 115
HLT GOTO3                                                   # 117

*** P1
"INPUT "                                                    # 8
