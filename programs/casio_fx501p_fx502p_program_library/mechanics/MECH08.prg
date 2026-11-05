# MECH08 - Forced vibration
# Mechanics-8, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mechanics-8
# prg code converted from the original document by Claude Code
#
# Input K, W, a, w, t0 and dt; then t (PAUSE) and x (HLT) are output
# for t = 0, dt, 2dt, ... up to t0.
# P1 leaves the multiplication open, which the caller completes.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MECH08,
# with prompts and alpha output, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 86
# @calculator 502
# @number 208

*** P0
MAC RAD                                                     # 2
HLT Min1 HLT Min2 HLT Min3 HLT Min4 HLT MinF HLT Min5       # 14
MR1 * 9 8 0 / MR2 = SQR Min6                                # 24
* MR3 / ( MR6 x^2 - MR4 x^2 ) * *                           # 36
MR4 = Min8 MR6 = Min9 AC                                    # 43
LBL1 MR7 * MR4 GSBP1 MR9 = Min0 MR7 * MR6                   # 54
GSBP1 MR8 = M-0                                             # 58
MR7 x>=F GOTO2 PAUSE                                        # 62
MR0 HLT MR5 M+7 GOTO1                                       # 67
LBL2 PAUSE MR0                                              # 70

*** P1
= / 2 / PI = FRAC * 2 * PI = sin *                          # 14
