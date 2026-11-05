# MECH07 - Free vibration
# Mechanics-7, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mechanics-7
# prg code converted from the original document by Claude Code
#
# P1..P5 data input, P0 calculates spring constant K, mass m and
# natural frequency f.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MECH07,
# with prompts and alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 56
# @calculator 502
# @number 207

*** P1
Min1                                                        # 1

*** P2
Min2                                                        # 1

*** P3
Min3                                                        # 1

*** P4
Min4                                                        # 1

*** P5
Min5 HLT Min6 HLT Min7                                      # 5

*** P0
MR4 * MR1 x^y 4 / 8 / MR3 / MR2 x^y                         # 12
3 = Min8                                                    # 15
PI * MR5 x^2 * MR6 * MR7 / 4 / 9 8 0                        # 29
= Min9                                                      # 31
MR8 / MR9 = SQR / 2 / PI =                                  # 41
