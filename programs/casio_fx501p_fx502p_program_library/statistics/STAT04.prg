# STAT04 - 12-month moving average
# Statistics-4, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-4, first program
# prg code converted from the original document by Claude Code
#
# Enter twelve values, then each further value gives the next average.
# The sheet also has the n-month program (n = 2..19), see STAT04N.
# FX-601P/FX-602P version: only the n-month program,
# casio_fx601p_fx602p_program_library STAT03.
# The comment behind a line is the step number of the program sheet.
# Total 31
# @calculator 502
# @number 304

*** P0
MAC 1 2 Min0                                                # 4
LBL1 AC HLT IND Min0 M+F DSZ GOTO1                          # 12
LBL2 1 2 Min0                                               # 16
LBL3 MRF / 1 2 = HLT                                        # 23
M+F IND X<->M0 M-F DSZ GOTO3 GOTO2                          # 30
