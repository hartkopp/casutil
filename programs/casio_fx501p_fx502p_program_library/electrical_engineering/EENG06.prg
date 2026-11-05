# EENG06 - Design of an active band-pass filter
# Electrical engineering-6, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Electrical engineering-6
# prg code converted from the original document by Claude Code
#
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library EENG06,
# with prompts and alpha output, same formulas. If Q is too small the
# 502 version displays 0, the 602 version "Try again!".
# The comment behind a line is the step number of the program sheet.
# Total 77
# @calculator 502
# @number 156

*** P0
LBL1 HLT Min1 HLT Min2 HLT Min3 HLT EXP 6 +/- Min4 HLT EXP 6  # 15
+/- Min5 MR1 * 2 * PI = Min1                                # 24
MR2 / 2 = SQR MinF MR3 x>=F GOTO2 GOTO3                     # 34
LBL2 MR3 / MR2 / MR1 / MR4 = Min6 HLT                       # 45
MR3 * MR1 * ( MR4 + MR5 ) - MR6 1/x                         # 57
= 1/x HLT                                                   # 60
MR3 / MR1 * ( MR4 1/x + MR5 1/x ) =                         # 72
GOTO1                                                       # 73
LBL3 0 GOTO1                                                # 76
