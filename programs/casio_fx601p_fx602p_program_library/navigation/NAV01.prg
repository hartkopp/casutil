# NAV01 - Astronomical observation
# Navigation-1, description see Program Library FX-601P/FX-602P, page 163 - 164
# prg code converted from the original document by Claude Code
#
# P9 converts an angle d.ms to degrees. MODE 4 is DEG, INV with the key
# of degrees, minutes and seconds is DMS<-.
# The comment behind a line is the step number of the program sheet.
# Total 117
# @calculator 602
# @name "NAV01"
# @mode .20

*** P0
DEG                                                         # 1
"P?" HLT                                                    # 6
GSBP9 Min01                                                 # 8
"D/h?" HLT GSBP9 Min02                                      # 17
"t/A?" HLT GSBP9 Min03                                      # 26
MR01 sin * MR02 sin + MR01 cos * MR02 cos                   # 37
* MR03 cos = sin-1 Min04 DMS<-                              # 44
"h/D=#" HLT                                                 # 52
( MR02 sin - MR01 sin * MR04 sin ) /                        # 63
MR01 cos / MR04 cos = cos-1 Min05                           # 71
MR03 sin x>=0 GOTO3 MR05 GOTO4                              # 77
LBL3 3 6 0 - MR05 =                                         # 84
LBL4 DMS<- "A/t=#"                                          # 93

*** P9
Min09 INT + ( MR09 FRAC * 2 10^x )                          # 10
Min09 INT / 6 0 + MR09 FRAC / 3 6                           # 21
=                                                           # 22
