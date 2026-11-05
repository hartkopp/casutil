# STAT18 - Analysis of variance with two-way layout
# Statistics-18, description see Program Library FX-601P/FX-602P, page 131 - 132
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 230 (FX-602P only)
# @calculator 602
# @name "STAT18"
# @mode .55

*** P0
MAC                                                         # 1
"m" HLT Min01 MinF                                          # 7
"n" HLT Min02 Min1F 2 Min00                                 # 15
1 Min2F Min3F                                               # 20
LBL1 "x\AR2F,\AR3F" HLT                                     # 30
Min03 M+04 x^2 M+06 7 M+02                                  # 36
MR03 IND M+02 7 M-02 1 M+3F                                 # 44
IND DSZ GOTO1                                               # 47
DSZ IND DSZ GOTO2 GOTO3                                     # 52
LBL2 MR04 M+05 x^2 M+07 2 Min00 MR1F Min02                  # 61
0 Min04 1 M+2F Min3F GOTO1                                  # 69
LBL3 2 Min00 MR1F Min02 0 Min03                             # 76
LBL4 7 M+02 IND MR02 x^2 M+03 7 M-02                        # 85
IND DSZ GOTO4                                               # 88
MR04 M+05 x^2 M+07                                          # 92
MR05 x^2 / MRF / MR1F = Min01                               # 100
MR06 - MR01 = Min02 "ST=#"                                  # 110, 111
HLT                                                         # 112
MR07 / MR1F - MR01 = Min04 "SA=#"                           # 122, 125
HLT                                                         # 126
MR03 / MRF - MR01 = Min05 "SB=#"                            # 136, 139
HLT                                                         # 140
MR02 - MR04 - MR05 = Min06 "SE=#"                           # 150, 153
HLT                                                         # 154
MR04 / ( MRF - 1 ) = Min07 "VA=#"                           # 165, 169
HLT                                                         # 170
MR05 / ( MR1F - 1 ) = Min08 "VB=#"                          # 181, 185
HLT                                                         # 186
MR06 / ( MRF - 1 ) / ( MR1F - 1                             # 198
) = Min09 "VE=#" HLT                                        # 208
MR07 / MR09 = "FA=#"                                        # 218
HLT                                                         # 219
MR08 / MR09 = "FB=#"                                        # 229
