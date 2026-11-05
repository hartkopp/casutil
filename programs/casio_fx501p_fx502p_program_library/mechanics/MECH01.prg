# MECH01 - Cantilever under concentrated load
# Mechanics-1, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mechanics-1
# prg code converted from the original document by Claude Code
#
# Input E, I, a and P, then x repeatedly; output deflection y, slope and
# moment M (M is shown at the HLT behind LBL1, before the next x).
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MECH01,
# with alpha output in P1..P3, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 93
# @calculator 502
# @number 201

*** P0
HLT Min1 HLT Min2 HLT Min3 MinF HLT Min4                    # 9
/ 2 / MR1 / MR2 = Min6 / 3 = Min7 0 DEG                     # 23
LBL1 HLT Min5 x>=F GOTO2 GOTO3                              # 29
LBL2 MR7 * MR3 x^y 3 - MR6 * MR3 x^2 *                      # 41
MR5 = HLT                                                   # 44
MR6 * MR3 x^2 = +/- tan-1 HLT 0 GOTO1                       # 54
LBL3 MR7 * MR5 x^y 3 - MR6 * MR3 * MR5                      # 66
x^2 = HLT                                                   # 69
MR6 * MR5 * ( MR5 - 2 * MR3 ) = tan-1                       # 82
HLT MR4 * ( MR5 - MR3 ) = GOTO1                             # 92
