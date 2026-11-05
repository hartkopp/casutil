# PHYS05 - Equation of state of ideal gas
# Physics/chemistry-5, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Physics/chemistry-5
# prg code converted from the original document by Claude Code
#
# P1 calculates P, P2 V, P3 n and P4 t from the other three values,
# P0 stores the constants R = 0.082 and 273, P5 and P6 are subroutines.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library PHYS05,
# with prompts in P6..P9 and the constants in the data section, same
# formulas.
# The comment behind a line is the step number of the program sheet.
# Total 87
# @calculator 502
# @number 255

*** P1
HLT Min2 0 HLT Min3 0 HLT Min4 GSBP0                        # 9
GSBP5 MR2 =                                                 # 12

*** P2
HLT Min1 0 HLT Min3 0 HLT Min4 GSBP0                        # 9
GSBP5 MR1 =                                                 # 12

*** P3
HLT Min1 0 HLT Min2 0 HLT Min4 GSBP0                        # 9
GSBP6 ( MR4 + MR6 ) =                                       # 16

*** P4
HLT Min1 0 HLT Min2 0 HLT Min3 GSBP0                        # 9
GSBP6 MR3 = - MR6 =                                         # 15

*** P0
. 0 8 2 Min5 2 7 3 Min6                                     # 9

*** P5
MR3 * MR5 * ( MR4 + MR6 ) /                                 # 10

*** P6
MR1 * MR2 / MR5 /                                           # 6
