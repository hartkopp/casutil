# STAT02 - Geometrical and harmonic means
# Statistics-2, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-2
# prg code converted from the original document by Claude Code
#
# P1 geometrical mean, P2 harmonic mean: enter the data, then GOTO1.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT01,
# with prompts and alpha output, same formulas; there M00 counts from 1
# with ISZ, here M2 counts the data.
# The comment behind a line is the step number of the program sheet.
# Total 35
# @calculator 502
# @number 302

*** P1
MAC 1 Min1 0                                                # 4
LBL3 HLT * MR1 = Min1 1 M+2 0                               # 13
GOTO3                                                       # 14
LBL1 MR1 x^(1/y) MR2 =                                      # 19

*** P2
MAC                                                         # 1
LBL3 HLT 1/x M+1 1 M+2 0                                    # 8
GOTO3                                                       # 9
LBL1 MR2 / MR1 =                                            # 14
