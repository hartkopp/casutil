# MECH11 - Design of coil spring
# Mechanics-11, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mechanics-11
# prg code converted from the original document by Claude Code
#
# P1..P6 input of the data, P0, P7, P8 and P9 calculations.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MECH09,
# with alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 84
# @calculator 502
# @number 211

*** P1
Min1                                                        # 1

*** P2
Min2                                                        # 1

*** P3
Min3                                                        # 1

*** P4
Min4                                                        # 1

*** P5
Min5                                                        # 1

*** P6
Min6                                                        # 1

*** P0
MR1 x^y 4 * MR4 / 8 / MR2 x^y 3 /                           # 12
MR3 = HLT * MR5 =                                           # 18

*** P7
8 * MR2 x^y 3 * MR3 * MR6 / MR4 /                           # 12
MR5 = x^(1/y) 4 =                                           # 17

*** P8
MR1 x^y 4 * MR4 * MR5 / 8 / MR3 /                           # 12
MR6 = x^(1/y) 3 =                                           # 17

*** P9
MR1 x^y 4 * MR4 * MR5 / 8 / MR2 x^y                         # 12
3 / MR6 =                                                   # 16
