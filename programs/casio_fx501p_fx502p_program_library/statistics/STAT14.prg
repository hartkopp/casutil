# STAT14 - F-test
# Statistics-14, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-14
# prg code converted from the original document by Claude Code
#
# P0 input of the data x, P1 of the data y, P2 result: degrees of
# freedom and F0. The count n is taken from the statistic register M9.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT13,
# with prompts and alpha output and its own counter M00, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 41
# @calculator 502
# @number 314

*** P0
MAC                                                         # 1
LBL1 MR9 + 1 = HLT xD GOTO1                                 # 9

*** P1
MR9 Min1 sdn-1 x^2 Min2 SAC                                 # 6
LBL1 MR9 + 1 = HLT xD GOTO1                                 # 14

*** P2
MR1 - 1 = HLT MR9 - 1 = HLT                                 # 10
MR2 / sdn-1 x^2 =                                           # 15
