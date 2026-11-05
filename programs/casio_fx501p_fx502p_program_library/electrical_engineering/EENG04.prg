# EENG04 - Design of an active low-pass filter
# Electrical engineering-4, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Electrical engineering-4
# prg code converted from the original document by Claude Code
#
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library EENG04,
# with prompts and alpha output. Same formulas; C2 is output in F like
# in the Japanese 602 edition, the English 602 edition outputs it in uF
# (* 1 EXP 6).
# The comment behind a line is the step number of the program sheet.
# Total 52
# @calculator 502
# @number 154

*** P0
LBL1 HLT Min1 HLT Min2 HLT EXP 6 +/- Min3                   # 10
2 * PI * MR1 = Min4                                         # 17
2 SQR * MR2 * MR4 * MR3 = 1/x HLT                           # 28
* MR2 = HLT                                                 # 32
/ ( MR2 + 1 ) = HLT                                         # 40
2 * ( MR2 + 1 ) * MR3 = GOTO1                               # 51
