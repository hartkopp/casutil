# EENG03 - Impedance of series resonance circuit
# Electrical engineering-3, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Electrical engineering-3
# prg code converted from the original document by Claude Code
#
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library EENG03,
# with prompts and alpha output, f0 rounded with RND4. Same formulas,
# but there |Z| and the phase angle are calculated with R->P, here with
# SQR and tan-1 after setting DEG. The 602 version does not loop back.
# The comment behind a line is the step number of the program sheet.
# Total 95
# @calculator 502
# @number 153

*** P0
LBL1 HLT Min1 HLT Min2 HLT EXP 6 +/- Min3 HLT EXP 3 +/- Min4  # 15
MR3 * MR4 = SQR * 2 * PI = 1/x HLT                          # 27
* 2 * PI = Min5 * MR4 - MR5 1/x / MR3                       # 40
= Min6 MR1 + MR2 = Min7                                     # 47
MR6 x^2 + MR7 x^2 = Min0                                    # 54
MR1 * MR2 * MR7 + MR1 * MR6 x^2 = /                         # 66
MR0 = Min8 HLT                                              # 70
MR1 x^2 * MR6 / MR0 = Min9 HLT                              # 79
MR8 x^2 + MR9 x^2 = SQR HLT                                 # 87
MR9 / MR8 = DEG tan-1 GOTO1                                 # 94
