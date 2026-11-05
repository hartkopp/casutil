# STAT09 - Binomial and Poisson distributions
# Statistics-9, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-9
# prg code converted from the original document by Claude Code
#
# P1 binomial distribution (n, x, P), P2 Poisson distribution (m, x).
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT08,
# with prompts and alpha output, same formulas, but without loop.
# The comment behind a line is the step number of the program sheet.
# Total 56
# @calculator 502
# @number 309

*** P1
LBL1 HLT Min1 0 HLT Min2 0 HLT Min3                         # 9
MR1 - MR2 = Min4                                            # 14
MR1 x! / MR2 x! / MR4 x! * MR3                              # 24
x^y MR2 * ( 1 - MR3 ) x^y MR4 = GOTO1                       # 36

*** P2
LBL1 HLT Min1 0 HLT Min2                                    # 6
MR1 +/- e^x * MR1 x^y MR2 / MR2 x! =                        # 17
GOTO1                                                       # 18
