# BANK08 - Calendar calculation (number of days, date, weekday)
# Banking-8, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Banking-8 (marked "for FX-502P", the sheet
# describes a reduced version for the FX-501P)
# prg code converted from the original document by Claude Code
#
# P1 number of days between two dates, P2 date a number of days after a
# date. Years are entered as Showa years (1 or 2 digits) or as 1901 to
# 2099. After each date the month, day and weekday (0 Sunday .. 6
# Saturday) are shown in DMS format. P0 calculates the day number of a
# date, P3 the weekday, P4 is a subroutine of P2.
# FX-501P/FX-502P only, not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 211
# @calculator 502
# @number 458

*** P1
GSBP0 Min4 GSBP3                                            # 3
LBL1 GSBP0 Min5 GSBP3 HLT MR4 M-5 MR5 ABS GOTO1             # 13

*** P2
GSBP0 Min4 GSBP3                                            # 3
LBL1 DMS<- HLT + MR4 = Min5 - 1 2 2 . 1 = /                 # 18
MR8 = INT Min1 MR5 - ( MR8 * MR1 )                          # 29
INT = Min6 / MR9 = INT Min2 MR6 - (                         # 40
MR9 * MR2 ) INT = Min3 x=0 GSBP4 1 4                        # 51
MinF MR2 x>=F GOTO2                                         # 55
GOTO3                                                       # 56
LBL2 1 2 M-2                                                # 60
LBL3 1 M-2 3 MinF MR2 x>=F GOTO4 1 M+1                      # 70
LBL4 MR0 x=0 GOTO5 MR1 - 1 9 2 5 = Min1                     # 82
LBL5 MR1 + MR2 / 6 0 + MR3 / 6 0                            # 94
x^2 = GOTO1                                                 # 97

*** P0
HLT Min1 0 Min0 2 10^x MinF MR1 x>=F GOTO1 +                # 11
1 9 2 5 = Min1 1 Min0                                       # 19
LBL1 0 HLT Min2 Min7 0 HLT Min3 / 6 0 = M+7                 # 32
3 6 5 . 2 5 Min8 3 0 . 6 Min9 3 MinF                        # 46
MR2 x>=F GOTO2 1 M-1 1 2 M+2                                # 54
LBL2 1 M+2 MR1 * MR8 = INT + ( MR2 * MR9                    # 67
) INT + MR3 =                                               # 72

*** P3
+ 5 = / 7 = FRAC * 7 = RND1 / 6 0                           # 14
x^2 = M+7 MR7 DMS<-                                         # 19

*** P4
1 M-2 3 1 Min3                                              # 5
