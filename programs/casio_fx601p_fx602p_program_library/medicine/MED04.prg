# MED04 - Acidity of blood
# Medicine-4, description see Program Library FX-601P/FX-602P, page 141 - 142
# prg code converted from the original document by Claude Code
#
# Output P* and PH at 37 degrees C, [HCO3-], BE and I.
# The comment behind a line is the step number of the program sheet.
# Total 128
# @calculator 602
# @name "MED04"
# @mode .20

*** P0
LBL1 "T?" HLT Min01                                         # 7
"P\*?" HLT Min02                                            # 14
"PH?" HLT Min03                                             # 21
"H?" HLT Min04                                              # 27
3 7 - MR01 = Min01 * . 0 1 9                                # 38
= 10^x * MR02 = Min02 HLT                                   # 45
MR03 - . 0 1 4 6 * MR01 = Min03 HLT                         # 57
- 6 . 1 1 = Min05                                           # 64
. 0 3 0 7 * MR02 = Min06                                    # 73
* MR05 10^x = HLT                                           # 78
- ( 9 . 5 + 1 . 6 3 * MR04 )                                # 91
* ( 7 . 4 - MR03 ) - 2 4 =                                  # 103
* ( 1 - . 0 1 4 3 * MR04 ) = HLT                            # 117
1 + MR05 10^x = * MR06 = HLT                                # 126
GOTO1                                                       # 127
