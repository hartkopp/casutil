# MED04 - Indication of red corpuscle
# Medicine-4, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Medicine-4
# prg code converted from the original document by Claude Code
#
# Input C, Hct and Hb repeatedly; output Vm, Hm and Hbm.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MED03,
# with prompts and alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 33
# @calculator 502
# @number 354

*** P0
LBL1 HLT Min1 0 HLT Min2 0 HLT Min3                         # 9
MR2 * 1 0 / MR1 = HLT                                       # 17
/ MR2 * MR3 = HLT                                           # 23
MR3 * 1 0 0 / MR2 = GOTO1                                   # 32
