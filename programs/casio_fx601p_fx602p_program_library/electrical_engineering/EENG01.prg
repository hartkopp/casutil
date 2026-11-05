# EENG01 - Delta - Y conversion
# Electrical engineering-1, description see Program Library FX-601P/FX-602P,
# page 33 - 34
# prg code converted from the original document by Claude Code
#
# P1 converts delta to Y, P2 Y to delta.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 120
# @calculator 602
# @name "EENG01"
# @mode .20

*** P1
LBL1 1 Min00 GSBP3 HLT                                      # 5
GSBP5 GSBP3 HLT GSBP5 GSBP3 HLT                             # 11
GSBP5 MR01 + MR02 + MR03 = Min07                            # 19
GSBP4 MR01 * MR02 / MR07 = HLT                              # 27
GSBP4 MR02 * MR03 / MR07 = HLT                              # 35
GSBP4 MR03 * MR01 / MR07 = HLT GOTO1                        # 44

*** P2
LBL1 4 Min00 GSBP3 HLT                                      # 5
GSBP5 GSBP3 HLT GSBP5 GSBP3 HLT                             # 11
GSBP5 1 Min00 MR04 * MR05 + MR05 *                          # 20
MR06 + MR06 * MR04 = Min08                                  # 27
GSBP4 MR08 / MR05 = HLT                                     # 33
GSBP4 MR08 / MR06 = HLT                                     # 39
GSBP4 MR08 / MR04 = HLT GOTO1                               # 46

*** P3
"INPUT R\AR00 ?"                                            # 10, 12

*** P4
"ANS R\AR00"                                                # 8
PAUSE ISZ                                                   # 10

*** P5
IND Min00 ISZ                                               # 3
