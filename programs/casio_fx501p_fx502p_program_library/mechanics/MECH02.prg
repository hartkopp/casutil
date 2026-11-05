# MECH02 - Cantilever under distributed load
# Mechanics-2, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mechanics-2
# prg code converted from the original document by Claude Code
#
# Input E, I, b and W, then x repeatedly; output deflection y, slope,
# moment M and shearing force Ws (Ws is shown at the HLT behind LBL1).
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MECH02,
# the same program.
# The comment behind a line is the step number of the program sheet.
# Total 128
# @calculator 502
# @number 202

*** P0
HLT Min1 HLT Min2 HLT Min3 MinF HLT Min4                    # 9
/ 6 / MR1 / MR2 = +/- Min6 0 DEG                            # 20
LBL1 HLT Min5 x>=F GOTO2 GOTO3                              # 26
LBL2 MR6 * MR3 x^y 3 = Min7 * ( MR5 - MR3                   # 39
/ 4 ) = HLT                                                 # 44
MR7 tan-1 HLT                                               # 47
0 HLT 0 GOTO1                                               # 51
LBL3 MR5 x^2 Min8 MR3 * MR5 = Min9 MR3 x^2                  # 62
Min0 MR6 * MR5 = Min7 * MR5 * ( MR8 /                       # 74
4 - MR9 + 3 * MR0 / 2 ) = HLT                               # 86
MR7 * ( MR8 - 3 * MR9 + 3 * MR0 ) =                         # 100
tan-1 HLT                                                   # 102
MR4 +/- * ( MR8 / 2 - MR9 + MR0 / 2 )                       # 116
= HLT MR4 * ( MR3 - MR5 ) = GOTO1                           # 127
