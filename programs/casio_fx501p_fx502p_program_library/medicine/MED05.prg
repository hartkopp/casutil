# MED05 - Acidity of blood
# Medicine-5, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Medicine-5
# prg code converted from the original document by Claude Code
#
# Input T, P*, PH and H repeatedly; output Pco2 and PH at 37 degrees C,
# Tco2, BE and [HCO3-] (shown at the HLT behind LBL1).
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MED04,
# with prompts, same formulas, but there [HCO3-] is output before BE
# and I = (1 + 10^M05) * M06 last, here this is Tco2 before BE.
# The German edition of the FX-501P/FX-502P library has the same
# program, its example shows Pco2, pH, Tco2, BE and [HCO3-].
# The comment behind a line is the step number of the program sheet.
# Total 115
# @calculator 502
# @number 355

*** P0
LBL1 HLT Min1 0 HLT Min2 0 HLT Min3 0 HLT Min4              # 12
3 7 - MR1 = Min1 * . 0 1 9 = 10^x *                         # 26
MR2 = Min2 HLT                                              # 30
MR3 - . 0 1 4 6 * MR1 = Min3 HLT                            # 42
- 6 . 1 1 = Min5                                            # 49
. 0 3 0 7 * MR2 = Min6 * ( 1 + MR5                          # 63
10^x ) = HLT                                                # 67
MR6 * MR5 10^x = Min6 - ( 9 . 5 + 1 .                       # 81
6 3 * MR4 ) * ( 7 . 4 - MR3 ) - 2 4                         # 97
= * ( 1 - . 0 1 4 3 * MR4 ) = HLT                           # 112
MR6 GOTO1                                                   # 114
