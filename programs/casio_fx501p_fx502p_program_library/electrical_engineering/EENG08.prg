# EENG08 - T- and pi-attenuators
# Electrical engineering-8, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Electrical engineering-8
# prg code converted from the original document by Claude Code
#
# P1 T-attenuator, P2 pi-attenuator, both with data input.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library EENG08,
# with prompts and alpha output and a common input in P0. Same formulas;
# the pi-attenuator uses N / Z0 / Z1 here, the 602 version inverts Z0
# and Z1 in M01 and M02.
# The comment behind a line is the step number of the program sheet.
# Total 85
# @calculator 502
# @number 158

*** P1
LBL1 HLT Min1 HLT Min2 HLT Min3                             # 7
* MR1 * MR2 GSBP3                                           # 12
* MR1 - MR4 = HLT                                           # 18
MR2 * MR5 - MR4 = HLT                                       # 25
MR4 GOTO1                                                   # 27

*** P2
LBL1 HLT Min1 HLT Min2 HLT Min3                             # 7
/ MR1 / MR2 GSBP3                                           # 12
/ MR1 - MR4 = 1/x HLT                                       # 19
MR5 / MR2 - MR4 = 1/x HLT                                   # 27
MR4 1/x GOTO1                                               # 30

*** P3
= SQR * 2 / ( MR3 - 1 ) = Min4                              # 12
( MR3 + 1 ) / ( MR3 - 1 ) = Min5                            # 25
