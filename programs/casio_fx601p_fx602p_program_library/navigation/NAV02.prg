# NAV02 - Great circle navigation
# Navigation-2, description see Program Library FX-601P/FX-602P, page 165 - 166
# prg code converted from the original document by Claude Code
#
# P9 converts an angle d.ms to degrees. MODE 4 is DEG, INV with the key
# of degrees, minutes and seconds is DMS<-.
# The comment behind a line is the step number of the program sheet.
# Total 125
# @calculator 602
# @name "NAV02"
# @mode .20

*** P0
DEG                                                         # 1
"N1?" HLT GSBP9 Min01                                       # 9
"E1?" HLT GSBP9 Min02                                       # 17
"N2?" HLT GSBP9 Min03                                       # 25
"E2?" HLT GSBP9 Min04                                       # 33
- MR02 = Min05                                              # 37
MR01 sin * MR03 sin + MR01 cos * MR03 cos                   # 48
* MR05 cos = cos-1 Min06 * 6 0 = Min07                      # 59
"D=#" HLT                                                   # 65
( MR03 sin - MR01 sin * MR06 cos ) /                        # 76
MR06 sin / MR01 cos = cos-1 Min08                           # 84
MR05 sin x>=0 GOTO1 3 6 0 -                                 # 92
LBL1 MR08 = DMS<- "T=#"                                     # 101

*** P9
Min09 INT + ( MR09 FRAC * 2 10^x )                          # 10
Min09 INT / 6 0 + MR09 FRAC / 3 6                           # 21
=                                                           # 22
