# MATH03 - Decimal - base-N conversion (n = 2 - 9)
# Mathematics-3, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-3
# prg code converted from the original document by Claude Code
#
# P1 decimal to base n, P2 base n to decimal, n in X before P1 or P2.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MATH03,
# with a prompt for n and the result with its base as alpha text.
# The comment behind a line is the step number of the program sheet.
# Total 52
# @calculator 502
# @number 103

*** P1
Min1 1 0 Min2 GSBP3                                         # 5

*** P2
Min2 1 0 Min1 GSBP3                                         # 5

*** P3
AC                                                          # 1
LBL1 HLT Min3 0 Min0 Min4                                   # 7
LBL2 MR3 / MR1 = INT Min5 x=0 GOTO3                         # 16
MR3 - MR5 * MR1 = GSBP4 MR5 Min3                            # 25
ISZ GOTO2                                                   # 27
LBL3 MR3 GSBP4 MR4 GOTO1                                    # 32

*** P4
* MR2 x^y MR0 = M+4                                         # 6
