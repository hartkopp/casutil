# EENG11 - Transistor amplifier
# Electrical engineering-11, description see Program Library FX-601P/FX-602P,
# page 53 - 58
# prg code converted from the original document by Claude Code
#
# P0 input of the h parameters, P1..P3 conversion of hb, he and hc, P4
# impedances and gains, P5..P9 subroutines.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 448 (P0..P2 on page 54, P3, P6..P8 on page 56, P5, P9, P4 on
# page 58, FX-602P only)
# @calculator 602
# @name "EENG11"
# @mode .20

*** P0
"h11(KOhm) ?" HLT EXP 3 Min01                               # 9, 17
"h12 ?"                                                     # 24
HLT Min02                                                   # 26
"h21 ?"                                                     # 33
HLT Min03                                                   # 35
"h22(\MUMho) ?" HLT EXP 6 +/- Min04                         # 44, 53
* MR01 - MR02 * MR03 =                                      # 60
Min05 1 + MR03 = Min06                                      # 66

*** P1
LBL1 "hb \-> he,hc" PAUSE GSBP0                             # 8, 15
LBL0 GSBP5 HLT GOTO1                                        # 19
LBL2 1 GSBP6 GOTO0                                          # 23
LBL3 2 GSBP6 GOTO0                                          # 27

*** P2
LBL2 "he \-> hb,hc" PAUSE GSBP0                             # 8, 15
LBL0 GSBP5 HLT GOTO2                                        # 19
LBL1 1 GSBP6 GOTO0                                          # 23
LBL3 3 GSBP6 GOTO0                                          # 27

*** P3
LBL3 "hc \-> hb,he" PAUSE GSBP0                             # 8, 15
LBL0 GSBP5 HLT GOTO3                                        # 19
LBL1 4 GSBP6 GOTO0                                          # 23
LBL2 3 GSBP6 GOTO0                                          # 27

*** P6
GSBP9 Min00 IND GOTO0                                       # 4
LBL1 MR06 GSBP8 GSBP7 +/- + MR05 =                          # 12
GSBP7 +/- GOTO9                                             # 15
LBL2 MR06 GSBP8 GSBP7 MR06 GSBP7                            # 21
1 +/- GOTO9                                                 # 24
LBL3 1 GSBP8 GSBP7 +/- + 1 = GSBP7                          # 33
MR06 +/- GOTO9                                              # 36
LBL4 MR03 +/- GSBP8 GSBP7 + MR03 =                          # 44
GSBP7 MR06 GSBP7                                            # 47
LBL9 GSBP7 GSBP7                                            # 50

*** P7
IND GOTO0                                                   # 2
LBL1 "h11(KOhm)" PAUSE / 3 10^x GOTO5                       # 12, 19
LBL2 "h12" PAUSE GOTO5                                      # 27
LBL3 "h21" PAUSE GOTO5                                      # 35
LBL4 "h22(\MUMho)" PAUSE * 6 10^x                           # 45, 51
LBL5 / MRF = HLT ISZ IND MR00                               # 59

*** P8
MinF 1 Min00 MR01                                           # 4

*** P5
"123:hbhehc"                                                # 9, 12

*** P9
"*ANSWERS*"                                                 # 11
PAUSE                                                       # 12

*** P4
LBL0 "hb \-> Z,A,G" PAUSE GSBP0                             # 9, 15
"Zg(KOhm) ?" HLT EXP 3 Min07                                # 24, 31
"Ze(KOhm) ?" HLT EXP 3 Min08                                # 40, 47
LBL9 GSBP9 "Zi(KOhm)" PAUSE MR01 - MR02 *                   # 57, 64
MR03 / ( MR04 + MR08 1/x )                                  # 72
= / 3 10^x = HLT                                            # 78
"Zo(KOhm)" PAUSE ( MR01 + MR07 ) /                          # 87, 95
( MR05 + MR04 * MR07 ) /                                    # 103
3 10^x = HLT                                                # 107
"Av" PAUSE MR03 *                                           # 114
MR08 / ( MR01 + MR05 *                                      # 121
MR08 ) = +/- Min09 HLT                                      # 127
"Ai" PAUSE MR03 /                                           # 134
MR08 / ( MR04 + MR08 1/x )                                  # 142
= +/- HLT                                                   # 145
"G" PAUSE * MR09 = HLT GOTO0                                # 154
