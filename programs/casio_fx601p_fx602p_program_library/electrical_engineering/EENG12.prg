# EENG12 - Four-terminal parameter conversion (Z, Y, G, H, F)
# Electrical engineering-12, description see Program Library FX-601P/FX-602P,
# page 59 - 66
# prg code converted from the original document by Claude Code
#
# P0 Z, P1 Y, P2 G, P3 H and P4 F conversion, P5..P9 subroutines.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 510 (P0, P1 on page 60, P2, P3 on page 62, P4, P5 on page 64,
# P6..P9 on page 66, FX-602P only)
# @calculator 602
# @name "EENG12"
# @mode .20

*** P0
LBL0 GSBP7 ";Z" PAUSE GSBP9                                 # 8
LBL9 GSBP6 HLT GOTO0                                        # 12
LBL1 "Z \-> Y" PAUSE                                        # 21
5 GSBP5 GOTO9                                               # 24
LBL2 "Z \-> G" PAUSE                                        # 33
1 GSBP5 GOTO9                                               # 36
LBL3 "Z \-> H" PAUSE                                        # 45
4 GSBP5 GOTO9                                               # 48
LBL4 "Z \-> F" PAUSE                                        # 57
3 GSBP5 GOTO9                                               # 60

*** P1
LBL1 GSBP7 ";Y" PAUSE GSBP9                                 # 8
LBL9 GSBP6 HLT GOTO1                                        # 12
LBL0 "Y \-> Z" PAUSE                                        # 21
5 GSBP5 GOTO9                                               # 24
LBL2 "Y \-> G" PAUSE                                        # 33
4 GSBP5 GOTO9                                               # 36
LBL3 "Y \-> H" PAUSE                                        # 45
1 GSBP5 GOTO9                                               # 48
LBL4 "Y \-> F" PAUSE                                        # 57
3 Min00 MR04 +/- GSBP8 1 +/-                                # 64
GSBP8 MR05 +/- GSBP8 MR01 +/-                               # 70
GSBP8 GOTO9                                                 # 72

*** P2
LBL2 GSBP7 ";G" PAUSE GSBP9                                 # 8
LBL9 GSBP6 HLT GOTO2                                        # 12
LBL0 "G \-> Z" PAUSE                                        # 21
1 GSBP5 GOTO9                                               # 24
LBL1 "G \-> Y" PAUSE                                        # 33
4 GSBP5 GOTO9                                               # 36
LBL3 "G \-> H" PAUSE                                        # 45
5 GSBP5 GOTO9                                               # 48
LBL4 "G \-> F" PAUSE                                        # 57
3 Min00 1 GSBP8 MR04 GSBP8                                  # 63
MR01 GSBP8 MR05 GSBP8 GOTO9                                 # 68

*** P3
LBL3 GSBP7 ";H" PAUSE GSBP9                                 # 8
LBL9 GSBP6 HLT GOTO3                                        # 12
LBL0 "H \-> Z" PAUSE                                        # 21
4 GSBP5 GOTO9                                               # 24
LBL1 "H \-> Y" PAUSE                                        # 33
1 GSBP5 GOTO9                                               # 36
LBL2 "H \-> G" PAUSE                                        # 45
5 GSBP5 GOTO9                                               # 48
LBL4 "H \-> F" PAUSE                                        # 57
3 Min00 MR05 +/- GSBP8 MR01 +/-                             # 64
GSBP8 MR04 +/- GSBP8 1 +/- GSBP8                            # 71
GOTO9                                                       # 72

*** P4
LBL4 GSBP7 ";F" PAUSE GSBP9                                 # 8
LBL9 GSBP6 HLT GOTO4                                        # 12
LBL0 "F \-> Z" PAUSE                                        # 21
3 GSBP5 GOTO9                                               # 24
LBL1 "F \-> Y" PAUSE                                        # 33
2 Min00 MR04 GSBP8 MR05 +/-                                 # 39
GSBP8 1 +/- GSBP8 MR01 GSBP8                                # 45
GOTO9                                                       # 46
LBL2 "F \-> G" PAUSE                                        # 55
1 Min00 MR03 GSBP8 MR05 +/-                                 # 61
GSBP8 1 GSBP8 MR02 GSBP8 GOTO9                              # 67
LBL3 "F \-> H" PAUSE                                        # 76
4 Min00 MR02 GSBP8 MR05                                     # 81
GSBP8 1 +/- GSBP8 MR03 GSBP8                                # 87
GOTO9                                                       # 88

*** P5
Min00 IND GOTO0                                             # 3
LBL5 MR04 GSBP8 MR02 +/- GSBP8                              # 9
MR03 +/- GSBP8 MR01 GOTO9                                   # 14
LBL1 1 GSBP8 MR02 +/- GSBP8 MR03                            # 21
GSBP8 MR05 GOTO9                                            # 24
LBL4 MR05 GSBP8 MR02 GSBP8 MR03                             # 30
+/- GSBP8 1 GOTO9                                           # 34
LBL3 MR01 GSBP8 MR05 GSBP8 1                                # 40
GSBP8 MR04                                                  # 42
LBL9 GSBP8                                                  # 44

*** P6
1 0 MinF AC                                                 # 4
"01234:ZYGHF"                                               # 16, 17

*** P7
"INPUT "                                                    # 8

*** P8
Min09 1 2 x=F GOTO1 1 GOTO2                                 # 7
LBL1 9                                                      # 9
LBL2 M+F MR09 "<\ARF>"                                      # 16, 17
PAUSE / IND MR00 = HLT                                      # 23

*** P9
"<11> ?"                                                    # 8
HLT Min01                                                   # 10
"<12> ?"                                                    # 18
HLT Min02                                                   # 20
"<21> ?"                                                    # 28
HLT Min03                                                   # 30
"<22> ?"                                                    # 38
HLT Min04 * MR01 - MR02 *                                   # 45
MR03 = Min05                                                # 48
