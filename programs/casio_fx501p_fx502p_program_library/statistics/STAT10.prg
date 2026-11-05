# STAT10 - Normal distribution
# Statistics-10, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-10
# prg code converted from the original document by Claude Code
#
# Input t with P0; output the probability (polynomial approximation).
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT09,
# the same program.
# The comment behind a line is the step number of the program sheet.
# Total 113
# @calculator 502
# @number 310

*** P0
Min1 * . 2 3 1 6 4 1 9 + 1 = 1/x Min2                       # 15
( 2 * PI ) SQR 1/x * ( MR1 x^2 / 2 +/-                      # 29
) e^x = Min3                                                # 33
1 - MR3 * ( . 3 1 9 3 8 1 5 3 * MR2                         # 49
- . 3 5 6 5 6 3 7 8 2 * MR2 x^2 +                           # 64
1 . 7 8 1 4 7 9 3 7 * MR2 x^y 3 -                           # 79
1 . 8 2 1 2 5 5 9 7 8 * MR2 x^y 4 +                         # 95
1 . 3 3 0 2 7 4 4 2 9 * MR2 x^y 5 )                         # 111
=                                                           # 112
