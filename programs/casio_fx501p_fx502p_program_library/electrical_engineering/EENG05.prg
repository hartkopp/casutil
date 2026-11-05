# EENG05 - Design of an active high-pass filter
# Electrical engineering-5, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Electrical engineering-5
# prg code converted from the original document by Claude Code
#
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library EENG05,
# with prompts and alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 54
# @calculator 502
# @number 155

*** P0
LBL1 HLT Min1 HLT Min2 HLT EXP 6 +/- Min3 HLT Min4          # 12
MR1 * 2 * PI = Min1                                         # 19
( 2 * MR2 + 1 ) / MR4 / MR1 / MR3 =                         # 33
HLT MR4 / MR1 / MR3 / ( 2 + MR2 1/x )                       # 46
= HLT MR3 / MR2 = GOTO1                                     # 53
