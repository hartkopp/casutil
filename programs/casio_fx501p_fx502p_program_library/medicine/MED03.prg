# MED03 - Surface area of a human body
# Medicine-3, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Medicine-3
# prg code converted from the original document by Claude Code
#
# Input height (cm) and weight (kg) repeatedly; output BSA(D) by DuBois
# if it is at least 0.6 (M F), otherwise BSA(B) by Boyd.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MED02,
# with prompts and alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 81
# @calculator 502
# @number 353

*** P0
LBL3 HLT Min1 0 HLT Min2 * 3 10^x = Min3 . 6 MinF           # 14
7 1 . 8 4 EXP 4 +/- * MR1 x^y . 7                           # 27
2 5 * MR2 x^y . 4 2 5 = Min4 x>=F                           # 39
GOTO2                                                       # 40
GOTO1                                                       # 41
LBL2 MR4 GOTO3                                              # 44
LBL1 . 7 2 8 5 - . 0 1 8 8 * MR3 log =                      # 60
Min5 3 . 2 0 7 EXP 4 +/- * MR3 x^y                          # 72
MR5 * MR1 x^y . 3 = GOTO3                                   # 80
