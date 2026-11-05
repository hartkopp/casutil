# PHYS04 - First- and second-order reaction speeds
# Physics/chemistry-4, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Physics/chemistry-4
# prg code converted from the original document by Claude Code
#
# P0 first-order reaction: input a, then m and t repeatedly (Ki is
# shown at the next HLT); GOTO1 outputs n, the mean K and the half-life.
# P1 second-order reaction with a <> b, P2 with a = b.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library PHYS04,
# with prompts and alpha output, same formulas. There the first-order
# reaction takes exactly four data pairs, and P2 handles a = b and
# a <> b.
# The comment behind a line is the step number of the program sheet.
# Total 105
# @calculator 502
# @number 254

*** P0
MAC HLT Min1 0                                              # 4
LBL3 HLT Min2 0 HLT Min3 MR1 / MR2 = ln / MR3 =             # 18
Min4 M+5 1 M+7 MR4 GOTO3                                    # 24
LBL1 MR5 / MR7 = Min5 2 ln / MR5 = Min6                     # 36
MR7 HLT MR5 HLT MR6                                         # 41

*** P1
MAC HLT Min1 0 HLT Min2 0                                   # 7
LBL4 HLT Min3 0 HLT Min4 MR2                                # 14
* MR3 / MR1 / ( MR2 + MR3 - MR1 ) =                         # 27
ln / MR4 / ( MR1 - MR2 ) = GOTO4                            # 38

*** P2
MAC HLT Min1 0                                              # 4
LBL5 HLT Min2 0 HLT Min3                                    # 10
( MR1 - MR2 ) / MR3 / MR1 / MR2 =                           # 22
GOTO5                                                       # 23
