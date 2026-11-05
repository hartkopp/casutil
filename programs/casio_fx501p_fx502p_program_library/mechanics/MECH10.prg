# MECH10 - Horsepower and shaft torque of an internal combustion engine
# Mechanics-10, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mechanics-10
# prg code converted from the original document by Claude Code
#
# Input Vs, Pmi, n, c and the mechanical efficiency (%) repeatedly;
# output indicated horsepower Ni, shaft horsepower Ne and torque T.
# FX-501P/FX-502P only, not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 44
# @calculator 502
# @number 210

*** P0
LBL1 HLT Min1 HLT Min2 HLT Min3 HLT / 4 = Min4 HLT EXP 2     # 15
+/- Min5 MR1 * MR2 * MR3 * MR4 / 4 5 EXP                    # 28
4 = HLT                                                     # 31
* MR5 = HLT                                                 # 35
* 7 1 6 / MR3 = GOTO1                                       # 43
