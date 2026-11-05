# STAT04N - n-month moving average (n = 2..19)
# Statistics-4, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-4, second program
# prg code converted from the original document by Claude Code
#
# Enter n, then n values; each further value gives the next average.
# Alternative to the 12-month program STAT04 on the same sheet, both
# use P0; the file number is the same as for STAT04.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT03,
# with prompts and alpha output, n in M1F instead of M.F, same
# algorithm.
# The comment behind a line is the step number of the program sheet.
# Total 28
# @calculator 502
# @number 304

*** P0
MAC Min0 Min.F                                              # 3
LBL1 AC HLT IND Min0 M+F DSZ GOTO1                          # 11
LBL2 MR.F Min0                                              # 14
LBL3 MRF / MR.F = HLT                                       # 20
M+F IND X<->M0 M-F DSZ GOTO3 GOTO2                          # 27
