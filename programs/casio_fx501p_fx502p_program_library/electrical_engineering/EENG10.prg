# EENG10 - Distributed constant circuit
# Electrical engineering-10, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Electrical engineering-10
# prg code converted from the original document by Claude Code
#
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library EENG10,
# with alpha output (FX-602P only there), same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 118
# @calculator 502
# @number 160

*** P0
HLT Min1 HLT EXP 3 +/- Min2 HLT / 6 10^x = Min3              # 13
HLT EXP 6 +/- Min4 DEG                                      # 19
LBL1 HLT * 2 * PI = Min5                                    # 27
MR1 x^2 + MR5 x^2 * MR2 x^2 = SQR Min6                      # 38
MR3 x^2 + MR5 x^2 * MR4 x^2 = SQR Min7                      # 49
MR5 * MR2 / MR1 = tan-1 Min8                                # 57
MR3 x=0 GOTO2 GOTO3                                         # 61
LBL2 9 0 Min9 GOTO4                                         # 66
LBL3 MR5 * MR4 / MR3 = tan-1 Min9                           # 75
LBL4 MR6 / MR7 = SQR HLT                                    # 82
( MR8 - MR9 ) / 2 = HLT                                     # 91
GSBP1 cos GSBP2 HLT                                         # 95
GSBP1 sin GSBP2 GOTO1                                       # 99

*** P1
( MR8 + MR9 ) / 2 =                                         # 8

*** P2
* ( MR6 * MR7 ) SQR =                                       # 8
