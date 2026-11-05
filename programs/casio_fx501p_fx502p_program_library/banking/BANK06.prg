# BANK06 - Calculation for discounting commercial bills (by annual interest
#          basis)
# Banking-6, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Banking-6
# prg code converted from the original document by Claude Code
#
# P0 input of the bills (amount, interest rate, days), P1 sums.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library BANK06,
# with prompts and alpha output and a counter, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 32
# @calculator 502
# @number 456

*** P0
MAC                                                         # 1
LBL1 HLT Min1 M+2 HLT Min3 HLT * MR1 * MR3 / 3 6            # 15
5 0 0 = INT M+4 GOTO1                                       # 22

*** P1
MR2 HLT - MR4 HLT - MR4 =                                   # 8
