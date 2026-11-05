# PHYS05 - Equation of state of ideal gas
# Physics/chemistry-5, description see Program Library FX-601P/FX-602P,
# page 95 - 96
# prg code converted from the original document by Claude Code
#
# P1 calculates P, P2 V, P3 n and P4 t, P5..P9 and P0 subroutines.
# M05 and M06 hold the constants of the sheet.
# The comment behind a line is the step number of the program sheet.
# Total 89
# @calculator 602
# @file all
# @name "PHYS05"
# @mode .20

*** P1
GSBP7 GSBP8 GSBP9                                           # 3
GSBP6                                                       # 4
GSBP0 MR02 =                                                # 7

*** P2
GSBP6 GSBP8 GSBP9                                           # 3
GSBP7                                                       # 4
GSBP0 MR01 =                                                # 7

*** P3
GSBP6 GSBP7 GSBP9                                           # 3
GSBP8                                                       # 4
GSBP5 ( MR04 + MR06 ) =                                     # 11

*** P4
GSBP6 GSBP7 GSBP8                                           # 3
GSBP9                                                       # 4
GSBP5 MR03 = - MR06 =                                       # 10

*** P6
"P=?" HLT Min01                                             # 7

*** P7
"V=?" HLT Min02                                             # 7

*** P8
"n=?" HLT Min03                                             # 7

*** P9
"t=?" HLT Min04                                             # 7

*** P0
MR03 * MR05 * ( MR04 + MR06 ) /                             # 10

*** P5
MR01 * MR02 / MR05 /                                        # 6

*** Data

M05  = 0.082  # gas constant R
M06  = 273
