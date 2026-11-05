# STAT16 - 2-by-2 contingency table
# Statistics-16, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-16
# prg code converted from the original document by Claude Code
#
# Input a, b, c and d; output chi-square and chi-square with Yates'
# correction.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT15,
# with prompts and alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 70
# @calculator 502
# @number 316

*** P0
HLT Min1 0 HLT Min2 0 HLT Min3 0 HLT Min4                   # 11
MR1 + MR3 = Min5 MR2 + MR4 = Min6                           # 21
MR1 + MR2 = Min7 MR3 + MR4 = Min8                           # 31
MR5 + MR6 = Min9                                            # 36
GSBP1 GSBP2                                                 # 38
GSBP1 ABS - MR9 / 2 = GSBP2                                 # 46

*** P1
MR1 * MR4 - MR2 * MR3 =                                     # 8

*** P2
x^2 * MR9 / MR5 / MR6 / MR7 / MR8 = HLT                     # 13
