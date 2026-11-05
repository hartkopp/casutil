# MECH06 - Beam fixed at both ends under distributed load
# Mechanics-6, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mechanics-6
# prg code converted from the original document by Claude Code
#
# Input E, I, l and W, then x repeatedly; output deflection y, slope,
# moment M and shearing force Ws (Ws is shown at the HLT behind LBL1).
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MECH06,
# with alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 102
# @calculator 502
# @number 206

*** P0
HLT Min1 HLT Min2 HLT Min3 HLT / 2 = Min4 0                 # 12
LBL1 HLT Min5 * MR4 / 6 / MR1 / MR2 = Min6                  # 25
MR3 x^2 Min7 MR6 / 2 * MR5 * ( MR5 *                        # 37
( 2 * MR3 - MR5 ) - MR7 ) = HLT                             # 49
MR6 * ( MR5 * ( 3 * MR3 - 2 * MR5 )                         # 63
- MR7 ) = DEG tan-1 HLT                                     # 70
MR4 / 6 * ( 6 * MR5 * ( MR3 - MR5 )                         # 84
- MR7 ) = HLT                                               # 89
MR4 +/- * ( 2 * MR5 - MR3 ) = GOTO1                         # 101
