# STAT06 - Spearman's coefficient of rank correlation
# Statistics-6, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-6
# prg code converted from the original document by Claude Code
#
# P0 input of the ranks A and B (the counter is shown before each pair),
# P1 result r.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT05,
# with alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 29
# @calculator 502
# @number 306

*** P0
MAC                                                         # 1
LBL1 ISZ MR0 HLT - 0 HLT = x^2 M+1 GOTO1                    # 12

*** P1
DSZ 1 - 6 * MR1 / ( MR0 x^y 3 -                             # 12
MR0 ) =                                                     # 15
