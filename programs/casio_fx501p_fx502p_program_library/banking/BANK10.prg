# BANK10 - Horizontal/vertical aggregate calculations
# Banking-10, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Banking-10
# prg code converted from the original document by Claude Code
#
# P0 input of the number of columns, then the data row by row (the row
# total is shown after each row), P1 column totals and grand total.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library BANK09,
# with prompts, alpha output and counters, same algorithm; here the row
# total is added up in the display.
# The comment behind a line is the step number of the program sheet.
# Total 31
# @calculator 502
# @number 460

*** P0
MAC MinF GOTO2                                              # 3
LBL1 HLT IND M+0 +                                          # 8
DSZ GOTO1                                                   # 10
LBL2 MRF Min0 0 = GOTO1                                     # 16

*** P1
MRF Min0 AC                                                 # 3
LBL1 IND MR0 HLT +                                          # 8
DSZ GOTO1                                                   # 10
0 = HLT                                                     # 13
