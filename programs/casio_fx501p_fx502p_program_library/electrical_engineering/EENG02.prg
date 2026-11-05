# EENG02 - Impedance of series and parallel circuits
# Electrical engineering-2, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Electrical engineering-2
# prg code converted from the original document by Claude Code
#
# P1..P4 input R, C, L and f, P0 calculates the series circuit, P5 the
# parallel circuit.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library EENG02,
# with alpha output. Same results, but calculated differently: here
# |Y|^2 = 1/R^2 + B^2 is kept in M7, |Z| and the phase angle are
# calculated directly. The 602 version shares the output of both
# circuits in P6 and gets |Z| and the phase angle with R->P.
# The comment behind a line is the step number of the program sheet.
# Total 89
# @calculator 502
# @number 152

*** P1
Min1                                                        # 1

*** P2
EXP 6 +/- Min2                                              # 4

*** P3
EXP 3 +/- Min3                                              # 4

*** P4
Min4 * 2 * PI = Min5                                        # 7

*** P0
MR5 * MR3 - MR5 1/x / MR2 = Min6                            # 10
MR1 HLT MR6 HLT                                             # 14
MR1 x^2 + MR6 x^2 = SQR HLT                                 # 22
MR6 / MR1 = tan-1                                           # 27

*** P5
MR5 * MR2 - MR5 1/x / MR3 = Min6                            # 10
MR1 x^2 1/x + MR6 x^2 = Min7                                # 18
MR7 * MR1 = 1/x HLT                                         # 24
MR6 / MR7 = +/- HLT                                         # 30
MR7 SQR 1/x HLT                                             # 34
MR1 * MR6 = +/- tan-1                                       # 40
