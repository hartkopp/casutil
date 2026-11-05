# EENG07 - Impedance of transmission line
# Electrical engineering-7, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Electrical engineering-7
# prg code converted from the original document by Claude Code
#
# P1 coaxial line, P2 parallel line, P3 single line above ground,
# P0 data input.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library EENG07,
# with prompts and alpha output, same formulas. Here the result stays
# in the display at the first HLT of P0 for the next input.
# The comment behind a line is the step number of the program sheet.
# Total 70
# @calculator 502
# @number 157

*** P0
HLT Min1 HLT Min2 HLT SQR Min3 MR1 / MR2 =                  # 11
Min5 1 3 8 . 0 5 9 8 2 4 Min4                               # 23

*** P1
LBL1 GSBP0 MR5 log * MR4 / MR3 = GOTO1                      # 10

*** P2
LBL1 GSBP0 MR5 x^2 - 1 = SQR + MR5 = log * 2                # 14
* MR4 / MR3 = GOTO1                                         # 20

*** P3
LBL1 GSBP0 MR5 * 4 = log * MR4 / MR3 = GOTO1                # 13
