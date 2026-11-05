# MECH04 - Simple beam under distributed load
# Mechanics-4, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mechanics-4
# prg code converted from the original document by Claude Code
#
# Input E, I, l and W, then x repeatedly; output deflection y, slope,
# moment M and shearing force Ws (Ws is shown at the HLT behind LBL1).
# P1 leaves two parentheses open, which P0 closes.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MECH04,
# with alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 88
# @calculator 502
# @number 204

*** P0
HLT Min1 HLT Min2 HLT Min3 HLT Min4 DEG                     # 9
LBL1 HLT Min5 MR4 / 2 4 / MR1 / MR2 = +/- Min6              # 23
MR3 x^y 3 = Min7                                            # 28
MR5 * GSBP1 - 2 * MR3 ) ) = HLT                             # 39
GSBP1 * 4 - 6 * MR3 ) ) = tan-1 HLT                         # 51
MR4 * MR5 / 2 * ( MR5 - MR3 ) = +/- HLT                     # 65
MR4 * ( MR3 / 2 - MR5 ) = GOTO1                             # 76

*** P1
MR6 * ( MR7 + MR5 x^2 * ( MR5                               # 10
