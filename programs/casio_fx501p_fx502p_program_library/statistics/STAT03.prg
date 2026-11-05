# STAT03 - 6-month moving average
# Statistics-3, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-3
# prg code converted from the original document by Claude Code
#
# Enter six values, then each further value gives the next average.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT02,
# with prompts and alpha output and a month counter in M09, same
# algorithm.
# The comment behind a line is the step number of the program sheet.
# Total 39
# @calculator 502
# @number 303

*** P0
MAC 6 Min0 MinF 0                                           # 5
LBL1 HLT IND Min0 M+7                                       # 10
DSZ GOTO1                                                   # 12
LBL2 MR7 / 6 = Min8 MR6 M-7                                 # 20
5 Min0                                                      # 22
LBL3 IND MR0 IND MinF 1 M-F                                 # 29
DSZ GOTO3                                                   # 31
6 MinF MR8 HLT                                              # 35
Min1 M+7 GOTO2                                              # 38
