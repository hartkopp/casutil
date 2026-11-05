# STAT08 - Quadratic regression analysis
# Statistics-8, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-8
# prg code converted from the original document by Claude Code
#
# P0 data input, P1 coefficients a, b, c and estimates y.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT07,
# with alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 112
# @calculator 502
# @number 308

*** P0
MAC                                                         # 1
LBL1 ISZ MR0 HLT xD * * = = M+6 = M+5                       # 13
0 HLT M+4 = M+3 = M+2 AC GOTO1                              # 22

*** P1
xbar * * MR4 = M-3                                          # 6
MR7 = M-6                                                   # 9
MR7 / MR9 * * MR4 = M-2                                     # 17
MR7 = M-5                                                   # 20
MR7 - xbar * MR8 = Min0 * MR5 - MR6                         # 31
x^2 = / / ( MR2 * MR0 - MR3 * MR6 )                         # 44
= Min1 HLT                                                  # 47
( MR3 * MR5 - MR2 * MR6 ) = Min0 HLT                        # 59
MR4 / MR9 - MR0 * xbar - MR1 * MR7 /                        # 71
MR9 = MinF                                                  # 74
LBL1 HLT Min9 x^2 * MR1 + MR9 * MR0 + MRF                   # 86
= GOTO1                                                     # 88
