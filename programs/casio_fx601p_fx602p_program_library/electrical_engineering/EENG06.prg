# EENG06 - Design of an active band-pass filter
# Electrical engineering-6, description see Program Library FX-601P/FX-602P,
# page 43 - 44
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 128
# @calculator 602
# @name "EENG06"
# @mode .20

*** P0
LBL1 "f0" HLT Min01                                         # 7
"A0" HLT Min02                                              # 13
"Q" HLT Min03                                               # 18
"C1" HLT EXP 6 +/- Min04                                    # 27
"C2" HLT EXP 6 +/- Min05                                    # 36
MR01 * 2 * PI = Min01                                       # 43
MR02 / 2 = SQR MinF                                         # 49
MR03 x>=F GOTO2 GOTO3                                       # 53
LBL2 1 Min00 GSBP1 MR03 / MR02 / MR01                       # 62
/ MR04 = Min06 HLT                                          # 67
GSBP1 MR03 * MR01 * ( MR04 + MR05 )                         # 77
- MR06 1/x = 1/x HLT                                        # 83
GSBP1 MR03 / MR01 * ( MR04 1/x +                            # 92
MR05 1/x ) = HLT GOTO1                                      # 98
LBL3 "Try again!"                                           # 107, 111

*** P1
"ANS R\AR00(Ohm)" PAUSE ISZ                                 # 9, 15
