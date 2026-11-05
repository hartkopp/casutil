# MED05 - Saturated and normal oxygen contents of blood
# Medicine-5, description see Program Library FX-601P/FX-602P, page 143 - 144
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 199
# @calculator 602
# @name "MED05"
# @mode .20

*** P0
LBL1 GSBP1 ";T" HLT Min01                                   # 8
GSBP1 ";P\*" HLT Min02                                      # 16
GSBP1 ";PH" HLT Min03                                       # 24
GSBP1 ";P" HLT Min04                                        # 31
GSBP1 ";H" HLT Min05                                        # 38
"S=" PAUSE                                                  # 43
3 7 - MR01 = Min01 * . 0 1 9 =                              # 55
10^x * MR02 = Min02                                         # 60
MR03 - . 0 1 4 6 * MR01 = Min03                             # 71
. 0 2 4 * MR01 + . 4 8 *                                    # 82
( MR03 - 7 . 4 ) + ( 4 0 / MR02                             # 95
) log * . 0 6 = 10^x * MR04 = Min06                         # 107
x^y 4 - 1 5 * MR06 x^y 3 =                                  # 117
Min07 + 2 0 4 5 * MR06 x^2 +                                # 127
2 EXP 3 * MR06 = / ( MR07 + 2                               # 138
4 0 0 * MR06 x^2 - 3 1 1 0 0                                # 150
* MR06 + 2 4 EXP 5 ) = Min08 * 2                            # 162
10^x = HLT                                                  # 165
"C=" PAUSE                                                  # 170
1 . 3 4 * MR08 * MR05 + . 0 0                               # 182
3 1 * MR06 = HLT                                            # 188
GOTO1                                                       # 189

*** P1
"INPUT "                                                    # 8
