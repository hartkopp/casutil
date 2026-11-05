# BANK11 - Money denomination calculation
# Banking-11, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Banking-11
# prg code converted from the original document by Claude Code
#
# P0 input of the amounts, P1 total and the number of 10000, 5000,
# 1000, 500, 100, 50, 10, 5 and 1 yen notes and coins.
# FX-501P/FX-502P only, not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 82
# @calculator 502
# @number 461

*** P0
MAC 5 MinF 0                                                # 4
LBL1 HLT Min6 M+9 4 Min0                                    # 10
LBL2 MR6 / 1 0 = Min6 FRAC * 1 0 = Min7                     # 23
MR6 INT Min6                                                # 26
MR7 x>=F GOTO3 GOTO4                                        # 30
LBL3 5 10^x IND M+0 MR7 - 5 =                               # 39
LBL4 IND M+0 DSZ GOTO2                                      # 44
MR6 M+5 0 GOTO1                                             # 48

*** P1
MR9 HLT MR5 HLT 4 MinF 0 Min0                               # 8
LBL1 ISZ IND MR0 / 5 10^x = Min6 INT HLT                    # 19
MR6 FRAC * 5 10^x = HLT                                     # 26
MR0 x>=F GOTO2 GOTO1                                        # 30
LBL2 AC                                                     # 32
