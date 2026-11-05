# MATH16 - Solving ordinary differential equation of the first order by
# the Runge-Kutta method
# Mathematics-16, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mathematics-16
# prg code converted from the original document by Claude Code
#
# P1 holds h f(x, y) of x in M4 and y in M5, here the example of the
# sheet.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MATH14,
# the same program with prompts and a step counter in MF.
# The comment behind a line is the step number of the program sheet.
# Total 91
# @calculator 502
# @number 116

*** P0
HLT Min1 HLT Min2 HLT Min3 / 2 = Min0                       # 10
LBL1 MR1 Min4 MR2 Min5 GSBP1 Min6                           # 17
MR1 + MR0 = Min4 MR2 + MR6 / 2 = Min5                       # 29
GSBP1 Min7 / 2 + MR2 = Min5 GSBP1 Min8 +                    # 40
MR2 = Min5 MR1 + MR3 = Min4 GSBP1 Min9                      # 50
MR1 + MR3 = Min1 HLT                                        # 56
MR2 + ( MR6 + 2 * MR7 + 2 * MR8 +                           # 69
MR9 ) / 6 = Min2 HLT GOTO1                                  # 77

*** P1
3 * MR5 / ( 1 + MR4 ) * MR3 =                               # 12
