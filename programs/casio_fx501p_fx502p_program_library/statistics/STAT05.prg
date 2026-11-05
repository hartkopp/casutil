# STAT05 - Correlation coefficient
# Statistics-5, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-5
# prg code converted from the original document by Claude Code
#
# P0 data input (x, y), P1 result r and r^2. The registers
# are M8 (sum x), M7 (sum x^2), M9 (n), M6 (sum y), M5 (sum y^2)
# and M4 (sum xy).
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT04,
# with prompts and alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 51
# @calculator 502
# @number 305

*** P0
MAC                                                         # 1
LBL1 ISZ MR0 HLT xD * 0 HLT M+6 Min3 = M+4                  # 13
MR3 x^2 M+5 GOTO1                                           # 17

*** P1
MR9 * MR4 - MR8 * MR6 = /                                   # 9
( ( MR9 * MR7 - MR8 x^2 ) *                                 # 19
( MR9 * MR5 - MR6 x^2 ) )                                   # 28
SQR = HLT x^2                                               # 32
