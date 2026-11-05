# GAME06 - Last-stone game II
# Game-6, description see Program Library FX-601P/FX-602P, page 179 - 182
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 219 (P5..P8 on page 180, P0..P4 on page 182, FX-602P only)
# @calculator 602
# @name "GAME06"
# @mode .20

*** P5
MR01 x>=0 GOTO1 GOTO2                                       # 4
LBL1 + MR02 x>=0 GOTO3 GOTO2                                # 10
LBL3 + MR03 x>=0 GOTO4 GOTO2                                # 16
LBL4 = x=0 GOTO2 "\AR01*\AR02*\AR03" GOTO5                  # 24, 28
LBL2 "END"                                                  # 34
LBL5                                                        # 35

*** P6
0 Min08 8 MinF 3 Min00                                      # 6
LBL1 IND MR00 x>=F GOTO2 GOTO3                              # 12
LBL2 MR00 + 3 = Min12 8 IND M-00 1 M+08                     # 23
LBL3 DSZ GOTO1                                              # 26

*** P7
3 Min00                                                     # 2
LBL1 IND MR00 IND M+00 DSZ GOTO1                            # 9

*** P8
0 Min00 2 MinF                                              # 4
MR04 x>=F 5 M+00                                            # 8
MR05 x>=F 5 M+00                                            # 12
MR06 x>=F 5 M+00                                            # 16
IND MR12 x>=F 5 M-00 3 MinF                                 # 23
MR00 x>=F GOTO3 IND GOTO0                                   # 28
LBL1 IND MR12 Min07 GOTO3                                   # 33
LBL0                                                        # 34
LBL2 IND MR12 - 1 = x=0 1 Min07                             # 43
LBL3 MR07                                                   # 45

*** P0
AC 3 Min00 RAN# RAN#                                        # 5
LBL1 * 1 0 + 6 = Min04 INT IND Min00                        # 16
MR04 FRAC DSZ GOTO1 GSBP5                                   # 21

*** P1
M-01 GSBP5                                                  # 2

*** P2
M-02 GSBP5                                                  # 2

*** P3
M-03 GSBP5                                                  # 2

*** P4
MR01 Min04 MR02 Min05 MR03 Min06 0 Min07                    # 8
Min13 8 Min11 Min09                                         # 12
LBL5 GSBP6 IND GOTO8                                        # 16
LBL3 MR11 M+07                                              # 19
LBL0                                                        # 20
LBL2 2 M-09 MR09 x=0 GOTO6                                  # 26
GSBP7 MR11 / 2 = Min11 GOTO5                                # 33
LBL1 MR13 x=0 GOTO7                                         # 37
MinF MR12 x=F GOTO3                                         # 41
MR11 M-07 GOTO2                                             # 44
LBL7 MR12 Min13 GOTO3                                       # 48
LBL6 MR07 x=0 1 Min07 MR13 x=0 GOTO9 Min12                  # 57
LBL9 GSBP8 IND M-12                                         # 61
MR04 Min01 MR05 Min02 MR06 Min03 GSBP5                      # 68
