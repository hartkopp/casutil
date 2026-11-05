# PHYS01 - Simple pendulum
# Physics/chemistry-1, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Physics/chemistry-1
# prg code converted from the original document by Claude Code
#
# Input l and x0, output period T; input the time interval, then t
# (PAUSE) and x (HLT) are output repeatedly.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library PHYS01,
# with prompts and alpha output and a counter; there M07 is cleared with
# 0 Min07, here with SAC.
# The comment behind a line is the step number of the program sheet.
# Total 46
# @calculator 502
# @number 251

*** P0
SAC HLT Min1 0 HLT Min2 MR1 / 9 8 0 = SQR                   # 13
* 2 * PI = Min3 HLT Min4 DEG                                # 22
LBL1 MR4 M+7 MR7 PAUSE                                      # 27
MR2 * ( ( MR7 / MR3 ) FRAC * 3 6 0 )                        # 41
cos = HLT GOTO1                                             # 45
