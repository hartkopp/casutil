# PHYS02 - Parabolic movement
# Physics/chemistry-2, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Physics/chemistry-2
# prg code converted from the original document by Claude Code
#
# Input V0, angle, h and dt; then t, x and y are output repeatedly.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library PHYS02,
# with prompts and alpha output, same formulas.
# The comment behind a line is the step number of the program sheet
# (sheet lines 1 and 2 joined, line 1 has no step number).
# Total 45
# @calculator 502
# @number 252

*** P0
DEG HLT Min1 0 HLT Min2 0 HLT Min3 0 HLT Min4 Min5           # 13
LBL1 MR5 HLT MR1 * MR2 cos * MR5 = HLT                      # 24
MR1 * MR2 sin * MR5 - 4 . 9 * MR5 x^2                       # 37
+ MR3 = HLT MR4 M+5 GOTO1                                   # 44
