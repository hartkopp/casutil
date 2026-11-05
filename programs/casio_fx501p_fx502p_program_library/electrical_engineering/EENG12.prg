# EENG12 - Four-terminal parameter conversion (Z, Y, G, H, F)
# Electrical engineering-12-1 and 12-2, description see Program Library
# FX-501P/FX-502P (Japanese edition), sheets Electrical engineering-12-1
# (P6..P9, P5, P4) and 12-2 (P0..P3)
# prg code converted from the original document by Claude Code
#
# P0 Z, P1 Y, P2 G, P3 H and P4 F conversion, P5..P9 subroutines.
# Input with Pn, then GOTOm converts to the parameter set of Pm.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library EENG12,
# with prompts and alpha output, same results. Here P5 shares the four
# conversion types (1) to (4) of the formula table, P7 divides by the
# register M0 points to, P8 = P7 with HLT, P6 = +/- with HLT.
# The comment behind a line is the step number of the program sheet.
# Total 255
# @calculator 502
# @number 162

*** P6
+/- HLT                                                     # 2

*** P7
/ IND MR0 =                                                 # 4

*** P8
GSBP7 HLT                                                   # 2

*** P9
Min1 HLT Min2 HLT Min3 HLT Min4                             # 7
* MR1 - MR2 * MR3 = Min5 AC                                 # 16

*** P5
Min0 IND GOTO0                                              # 3
LBL5 MR4 GSBP8 MR2 +/- GSBP8                                # 9
MR3 +/- GSBP8 MR1 GSBP7 GOTO9                               # 15
LBL1 MR1 1/x HLT * MR2 = GSBP6                              # 23
MR3 GSBP8 MR5 GSBP7 GOTO9                                   # 28
LBL4 MR5 GSBP8 MR2 GSBP8                                    # 33
MR3 +/- GSBP8 MR4 1/x GOTO9                                 # 39
LBL3 MR1 GSBP8 MR5 GSBP8                                    # 44
MR3 1/x HLT * MR4 =                                         # 50
LBL9                                                        # 51

*** P4
LBL4 HLT GSBP9 HLT                                          # 4
LBL0 3 GSBP5 GOTO4                                          # 8
LBL1 2 Min0 MR4 GSBP8 MR5 +/- GSBP8                         # 16
MR2 1/x GSBP6 * MR1 = +/- GOTO4                             # 24
LBL2 1 Min0 MR3 GSBP8 MR5 +/- GSBP8                         # 32
MR1 1/x HLT * MR2 = GOTO4                                   # 39
LBL3 4 Min0 MR2 GSBP8 MR5 GSBP8                             # 46
MR4 1/x GSBP6 * MR3 = +/- GOTO4                             # 54

*** P0
LBL0 HLT GSBP9 HLT                                          # 4
LBL1 5 GSBP5 GOTO0                                          # 8
LBL2 1 GSBP5 GOTO0                                          # 12
LBL3 4 GSBP5 GOTO0                                          # 16
LBL4 3 GSBP5 GOTO0                                          # 20

*** P1
LBL1 HLT GSBP9 HLT                                          # 4
LBL0 5 GSBP5 GOTO1                                          # 8
LBL2 4 GSBP5 GOTO1                                          # 12
LBL3 1 GSBP5 GOTO1                                          # 16
LBL4 3 Min0 MR4 +/- GSBP8 MR3 1/x GSBP6                     # 25
* MR5 = HLT MR1 GSBP7 +/- GOTO1                             # 33

*** P2
LBL2 HLT GSBP9 HLT                                          # 4
LBL0 1 GSBP5 GOTO2                                          # 8
LBL1 4 GSBP5 GOTO2                                          # 12
LBL3 5 GSBP5 GOTO2                                          # 16
LBL4 3 Min0 MR3 1/x HLT * MR4 = HLT                         # 26
MR1 GSBP8 MR5 GSBP7 GOTO2                                   # 31

*** P3
LBL3 HLT GSBP9 HLT                                          # 4
LBL0 4 GSBP5 GOTO3                                          # 8
LBL1 1 GSBP5 GOTO3                                          # 12
LBL2 5 GSBP5 GOTO3                                          # 16
LBL4 3 Min0 MR5 +/- GSBP8 MR1 +/- GSBP8                     # 25
MR4 +/- GSBP8 / MR4 = GOTO3                                 # 32
