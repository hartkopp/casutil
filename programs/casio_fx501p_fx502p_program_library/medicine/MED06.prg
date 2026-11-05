# MED06 - Saturated and normal oxygen contents of blood
# Medicine-6, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Medicine-6
# prg code converted from the original document by Claude Code
#
# Input T, P*, PH, P and H repeatedly; output S and C.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MED05,
# with prompts and alpha output, same formulas; here the input is done
# with MAC and X<->M (the display shows 0 after each input), there with
# Min.
# The comment behind a line is the step number of the program sheet.
# Total 153
# @calculator 502
# @number 356

*** P0
LBL1 MAC HLT X<->M1 HLT X<->M2 HLT X<->M3 HLT X<->M4 HLT Min5  # 12
3 7 - MR1 = Min1 * . 0 1 9 = 10^x *                         # 26
MR2 = Min2                                                  # 29
MR3 - . 0 1 4 6 * MR1 = Min3                                # 40
. 0 2 4 * MR1 + . 4 8 * ( MR3 -                             # 54
7 . 4 ) + ( 4 0 / MR2 ) log * . 0 6                         # 70
= 10^x * MR4 = Min6                                         # 76
x^y 4 - 1 5 * MR6 x^y 3 = Min7 + 2 0                        # 90
4 5 * MR6 x^2 + 2 EXP 3 * MR6 = / (                         # 104
MR7 + 2 4 0 0 * MR6 x^2 - 3 1 1 0 0                         # 119
* MR6 + 2 4 EXP 5 ) = Min8 * 2 10^x = HLT                   # 134
1 . 3 4 * MR8 * MR5 + . 0 0 3 1 *                           # 149
MR6 = GOTO1                                                 # 152
