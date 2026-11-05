# EENG08 - T- and pi-attenuators
# Electrical engineering-8, description see Program Library FX-601P/FX-602P,
# page 47 - 48
# prg code converted from the original document by Claude Code
#
# P1 T-attenuator, P2 pi-attenuator, P0 data input.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 127
# @calculator 602
# @name "EENG08"
# @mode .20

*** P0
"; type" PAUSE                                              # 7, 9
"Z0 ?" HLT Min01                                            # 17
"Z1 ?" HLT Min02                                            # 25
"N ?" HLT Min03                                             # 32
1 Min00                                                     # 34

*** P1
LBL1 "T" GSBP0 GSBP3 GSBP4 HLT                              # 8
GSBP4 HLT                                                   # 10
GSBP5 MR04 HLT GOTO1                                        # 14

*** P2
LBL1 "\PI" GSBP0 MR01 1/x Min01                             # 8
MR02 1/x Min02 GSBP3 GSBP4 1/x HLT                          # 15
GSBP4 1/x HLT                                               # 18
GSBP5 MR04 1/x HLT GOTO1                                    # 23

*** P3
MR03 * MR01 * MR02 = SQR                                    # 7
* 2 / ( MR03 - 1 ) Min05 = Min04                            # 18
( MR03 + 1 ) / MR05 = Min05                                 # 27

*** P4
GSBP5                                                       # 1
IND MR00 * MR05 - MR04 = ISZ                                # 9

*** P5
"ANS R\AR00(Ohm)" PAUSE                                     # 9, 14
