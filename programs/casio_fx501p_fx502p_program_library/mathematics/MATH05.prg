# MATH05 - Polynomial calculations
# Mathematics-5, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-5
# prg code converted from the original document by Claude Code
#
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MATH05,
# another program with prompts, up to degree 77.
# The comment behind a line is the step number of the program sheet.
# Total 30
# @calculator 502
# @number 105

*** P0
MAC Min0 X<->MF                                             # 3
LBL1 HLT IND X<->M0 DSZ GOTO1                               # 9
HLT X<->M9                                                  # 11
LBL2 HLT Min8 MRF Min0 AC                                   # 17
LBL3 IND MR0 = * MR8 + DSZ GOTO3                            # 26
MR9 = GOTO2                                                 # 29
