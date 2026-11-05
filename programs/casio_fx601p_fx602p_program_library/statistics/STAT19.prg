# STAT19 - Multiple correlation coefficient
# Statistics-19, description see Program Library FX-601P/FX-602P, page 133 - 134
# prg code converted from the original document by Claude Code
#
# P0 data input, P1 result, P2 subroutine.
# The comment behind a line is the step number of the program sheet.
# Total 150
# @calculator 602
# @name "STAT19"
# @mode .20

*** P0
MAC 1 Min17 Min18                                           # 4
LBL1 "x\AR17,\AR18" HLT                                     # 12
Min01 M+04 x^2 M+03 1 M+17                                  # 18
"x\AR17,\AR18" HLT                                          # 25
Min02 M+06 x^2 M+05                                         # 29
"y\AR18" HLT xD * * MR01                                    # 38
= M+11 MR02 = M+12                                          # 43
MR01 * MR02 = M+13 1 Min17 M+18 GOTO1                       # 52

*** P1
MR13 Min10 MR04 Min01 MR06 Min02 MR03                       # 7
MinF MR05 Min00 GSBP2 Min14                                 # 12
MR11 Min10 MR08 Min02 MR07 Min00 GSBP2                      # 19
Min15 MR12 Min10 MR06 Min01 MR05 MinF                       # 26
GSBP2 Min16                                                 # 28
1 - ( 1 + 2 * MR14 * MR15 * MR16                            # 40
- MR14 x^2 - MR15 x^2 - MR16 x^2                            # 49
) / ( 1 - MR14 x^2 ) = SQR                                  # 59
"P=#"                                                       # 64

*** P2
( MR09 * MR10 - MR01 * MR02 ) / (                           # 11
( MR09 * MRF - MR01 x^2 ) * (                               # 21
MR09 * MR00 - MR02 x^2 ) ) SQR =                            # 31
