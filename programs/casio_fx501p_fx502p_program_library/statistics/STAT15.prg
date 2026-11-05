# STAT15 - t-test
# Statistics-15, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-15
# prg code converted from the original document by Claude Code
#
# P0, P1 paired data, P2..P4 two samples.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT14,
# with prompts and alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 104
# @calculator 502
# @number 315

*** P0
MAC                                                         # 1
LBL1 MR9 + 1 = HLT Min1 0 HLT Min2 MR1 - MR2 = xD           # 16
GOTO1                                                       # 17

*** P1
MR9 - 1 = HLT SQR * xbar / sdn =                            # 11

*** P2
MAC                                                         # 1
LBL1 MR9 + 1 = HLT xD GOTO1                                 # 9

*** P3
MR9 Min1 MR7 Min2 xbar Min3 SAC                             # 7
LBL1 MR9 + 1 = HLT xD GOTO1                                 # 15

*** P4
Min4 MR1 + MR9 - 2 = Min5 HLT                               # 9
( MR3 - xbar - MR4 ) / ( MR1 1/x +                          # 21
MR9 1/x ) SQR / ( ( MR2 - MR1 * MR3                         # 33
x^2 + MR7 - MR9 * xbar x^2 ) / MR5 )                        # 45
SQR =                                                       # 47
