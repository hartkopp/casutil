# MECH12 - Thermal stress
# Mechanics-12, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mechanics-12
# prg code converted from the original document by Claude Code
#
# Input L1, L2, E1, E2, A1, A2 and T repeatedly; output the stresses.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MECH10,
# with prompts and alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 51
# @calculator 502
# @number 212

*** P0
LBL1 HLT Min1 HLT Min2 HLT Min3 HLT Min4 HLT Min5 HLT Min6  # 13
HLT Min7                                                    # 15
( MR3 * MR4 * ( MR1 - MR2 ) * MR7 )                         # 28
/ ( MR3 * MR5 + MR4 * MR6 ) = Min8                          # 40
* MR6 +/- = HLT                                             # 45
MR8 * MR5 = GOTO1                                           # 50
