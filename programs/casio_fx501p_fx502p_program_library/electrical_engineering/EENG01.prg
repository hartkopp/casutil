# EENG01 - Delta - Y conversion
# Electrical engineering-1, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Electrical engineering-1
# prg code converted from the original document by Claude Code
#
# P1 converts delta to Y, P2 Y to delta.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library EENG01,
# with prompts and alpha output. There the third result is followed by
# HLT GOTO1, here GOTO1 runs into the HLT behind LBL1.
# The comment behind a line is the step number of the program sheet.
# Total 71
# @calculator 502
# @number 151

*** P1
LBL1 HLT Min1 HLT Min2 HLT Min3                             # 7
MR1 + MR2 + MR3 = Min7                                      # 14
MR1 * MR2 / MR7 = HLT                                       # 21
MR2 * MR3 / MR7 = HLT                                       # 28
MR3 * MR1 / MR7 = GOTO1                                     # 35

*** P2
LBL1 HLT Min4 HLT Min5 HLT Min6                             # 7
MR4 * MR5 + MR5 * MR6 + MR6 * MR4                           # 18
= Min8                                                      # 20
/ MR5 = HLT                                                 # 24
MR8 / MR6 = HLT                                             # 29
MR8 / MR4 = GOTO1                                           # 34
