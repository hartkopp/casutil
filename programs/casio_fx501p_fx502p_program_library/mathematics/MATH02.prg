# MATH02 - Greatest common measure
# Mathematics-2, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-2
# prg code converted from the original document by Claude Code
#
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MATH02,
# the same program with input prompts, here a is entered before P0.
# The comment behind a line is the step number of the program sheet.
# Total 30
# @calculator 502
# @number 102

*** P0
ABS Min1 MinF 0 HLT ABS Min2                                # 7
x>=F X<->M1 Min2                                            # 10
LBL1 MR1 / MR2 = INT * MR2 - MR1 = +/-                      # 22
x=0 GOTO2                                                   # 24
X<->M2 Min1 GOTO1                                           # 27
LBL2 MR2                                                    # 29
