# BANK07 - Calculating for depreciation
# Banking-7, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Banking-7
# prg code converted from the original document by Claude Code
#
# P1 straight-line method, P2 declining-balance method, both with the
# input of P, r, n and m; P0 subroutine.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library BANK07,
# with prompts and alpha output and a common input in P3, same formulas.
# The comment behind a line is the step number of the program sheet.
# Total 101
# @calculator 502
# @number 457

*** P1
LBL1 HLT Min1 HLT / 2 10^x = Min2 HLT Min3 HLT Min4         # 13
MinF MR3 1/x * 3 10^x GSBP0 1 x=F GOTO2                     # 23
MR5 / 2 * 3 10^x + . 5 GSBP0                                # 33
LBL2 MR1 * ( 1 - MR2 ) * MR5 = GOTO1                        # 45

*** P0
= INT / 3 10^x = Min5                                       # 7

*** P2
LBL1 MAC HLT Min1 HLT / 2 10^x = Min2 HLT * HLT =           # 14
Min0 1 - MR2 x^(1/y) MR0 = RND3 Min5                        # 23
LBL2 1 M+6 MR6 HLT MR1 * MR5 = INT Min7 M+8 HLT             # 36
MR1 - MR7 = Min1 HLT                                        # 42
DSZ GOTO2                                                   # 44
MR8 GOTO1                                                   # 46
