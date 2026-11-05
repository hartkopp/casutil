# MED01 - Removal of urea
# Medicine-1, description see Program Library FX-601P/FX-602P, page 135 - 136
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 128
# @calculator 602
# @name "MED01"
# @mode .20

*** P0
LBL0 GSBP2 ";Vt" HLT MinF                                   # 9
GSBP2 ";U" HLT Min02                                        # 16
GSBP2 ";B" HLT Min03                                        # 23
GSBP2 PAUSE "BSA or 0" HLT Min04                            # 31, 37
x=0 GOTO1                                                   # 39
"Vt*=" PAUSE                                                # 46
1 . 7 3 / MR04 * MRF = MinF HLT                             # 57
LBL1 2 x>=F GOTO2                                           # 61
"Cm=" PAUSE GSBP1                                           # 68
"<Cm>=" PAUSE                                               # 76
1 . 3 3 = HLT GOTO0                                         # 83
LBL2 "Cs=" PAUSE                                            # 90
MRF SQR MinF GSBP1                                          # 94
"<Cs>=" PAUSE                                               # 102
1 . 8 5 = HLT GOTO0                                         # 109

*** P1
MR02 * MRF / MR03 = HLT *                                   # 8

*** P2
"INPUT "                                                    # 8
