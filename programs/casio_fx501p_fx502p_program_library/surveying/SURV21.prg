# SURV21 - Perpendicular and distance 1 (three points known)
# Surveying-21, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-21
# prg code converted from the original document by Claude Code
#
# Input A and B of the line AB, then repeatedly a point C; output the
# foot P of the perpendicular from C on AB and the distance l = CP,
# rounded to three decimals by P8. The slope m of AB is kept in M7,
# XP and YP replace XB and YB in M3 and M4.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 99
# @calculator 502
# @number 421

*** P0
AC HLT Min1 0                                               # 4
HLT Min2 0                                                  # 7
HLT Min3 0                                                  # 10
HLT Min4 ( MR2 - MR4 ) / ( MR1 - MR3 )                      # 23
= Min7 AC                                                   # 26
LBL1 HLT Min5 0                                             # 30
HLT Min6                                                    # 32
MR7 * MR1 + MR7 1/x * MR5 - MR2 +                           # 43
MR6 = / ( MR7 + MR7 1/x ) = GSBP8                           # 54
Min3 HLT                                                    # 56
MR2 + MR7 * ( MR3 - MR1 ) = GSBP8                           # 67
Min4 HLT                                                    # 69
( MR5 - MR3 ) x^2 + ( MR6 - MR4 )                           # 81
x^2 = SQR GSBP8 GOTO1                                       # 86

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
