# MATH09 - Transformation of coordinates
# Mathematics-9, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-9
# prg code converted from the original document by Claude Code
#
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MATH08,
# with prompts and alpha output.
# The comment behind a line is the step number of the program sheet.
# Total 44
# @calculator 502
# @number 109

*** P0
LBL1 HLT Min1 HLT Min2 HLT Min3 HLT Min4 HLT Min5           # 11
MR1 - MR3 = Min6 MR2 - MR4 = Min7                           # 21
MR6 * MR5 cos + MR7 * MR5 sin = HLT                         # 32
MR7 * MR5 cos - MR6 * MR5 sin = GOTO1                       # 43
