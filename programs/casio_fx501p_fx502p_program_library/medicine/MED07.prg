# MED07 - Discomfort index
# Medicine-7, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Medicine-7
# prg code converted from the original document by Claude Code
#
# DI = 1.8 D - 0.55 (1 - H / 100) (1.8 D - 26) + 32, integer part.
# Input temperature D (degrees C) and humidity H (%) repeatedly.
# FX-501P/FX-502P only, not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 43
# @calculator 502
# @number 357

*** P0
LBL1 HLT Min1 0 HLT Min2                                    # 6
1 . 8 * MR1 - . 5 5 * ( 1 - MR2 /                           # 21
1 0 0 ) * ( 1 . 8 * MR1 - 2 6 ) +                           # 37
3 2 = INT GOTO1                                             # 42
