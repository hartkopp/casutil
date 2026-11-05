# MED01 - Biorhythm
# Medicine-1, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Medicine-1
# prg code converted from the original document by Claude Code
#
# Input the date of birth (year, month, day), then repeatedly the date
# wanted; output the number of days and the physical (23 days),
# sympathy (28 days) and intellectual (33 days) rhythm, rounded to two
# decimals. P1 calculates the day number of a date.
# FX-501P/FX-502P only, not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 89
# @calculator 502
# @number 351

*** P0
HLT Min1 0 HLT Min2 0 HLT Min3 3 MinF                       # 10
GSBP1 Min4 0                                                # 13
LBL1 HLT Min1 0 HLT Min2 0 HLT Min3                         # 22
GSBP1 Min5 MR4 M-5 1 8 Min6 3 Min0 MR5 DEG                  # 33
LBL2 HLT 5 M+6 MR5 / MR6 = FRAC * 3 6 0 =                   # 47
sin RND2 DSZ GOTO2                                          # 51
GOTO1                                                       # 52

*** P1
MR2 x>=F GOTO3 1 M-1 1 2 M+2                                # 8
LBL3 1 M+2 MR1 * 3 6 5 . 2 5 = INT + (                      # 23
MR2 * 3 0 . 6 = INT ) + MR3 =                               # 35
