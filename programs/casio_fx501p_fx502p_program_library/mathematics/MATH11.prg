# MATH11 - 3 variable linear equations
# Mathematics-11, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-11
# prg code converted from the original document by Claude Code
#
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MATH10,
# with prompts and alpha output.
# The comment behind a line is the step number of the program sheet.
# Total 126 (FX-502P only)
# @calculator 502
# @number 111

*** P0
1 2 Min0 AC                                                 # 4
LBL1 HLT IND Min0 DSZ GOTO1                                 # 10
1 3 Min.3 GSBP2                                             # 14
4 Min.7 1 GSBP5 GSBP2                                       # 19
1 Min.7 3 GSBP5                                             # 23
3 Min.7 4 GSBP5 GSBP2                                       # 28
MR.5 / MR.4 = Min.7 HLT                                     # 34
MR.6 / MR.4 = Min.8 HLT                                     # 40
( MR.1 - MR.7 * MR.2 - MR.8 *                               # 49
MR9 ) / MR.0 = HLT                                          # 55

*** P1
MR.2 * MR7 * MR2 + MR.1 * MR6                               # 9
* MR4 + MR.0 * MR8 * MR3 - ( MR.0                           # 20
* MR7 * MR4 + MR6 * MR3 * MR.2 +                            # 31
MR2 * MR.1 * MR8 ) = IND Min.3                              # 40

*** P2
1 M+.3 GSBP1                                                # 3

*** P3
IND MR.7 MinF IND MR.8 IND Min.7                            # 7
MRF IND Min.8                                               # 10

*** P4
LBL1 4 M+.7 M+.8 GSBP3 DSZ GOTO1                            # 7

*** P5
Min.8 2 Min0 GSBP3 GSBP4                                    # 5
