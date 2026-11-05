# NAV03 - Rhumb line navigation
# Navigation-3, description see Program Library FX-601P/FX-602P, page 167 - 168
# prg code converted from the original document by Claude Code
#
# P9 converts an angle d.ms to degrees, P6..P8 subroutines. MODE 4 is DEG,
# INV with the key of degrees, minutes and seconds is DMS<-.
# The listing follows the English sheet, the Japanese one has GSB 4,
# GOTO2 and a division instead of GOTO4, GOTO3 and + in P9.
# The comment behind a line is the step number of the program sheet.
# Total 150
# @calculator 602
# @name "NAV03"
# @mode .20

*** P0
DEG MAC                                                     # 2
"N1?" HLT GSBP9 X<->M01                                     # 10
"E1?" HLT GSBP9 X<->M02                                     # 18
"N2?" HLT GSBP9 X<->M03                                     # 26
"E2?" HLT GSBP9 M-02                                        # 34
1 8 0 MinF MR02 ABS x>=F GSBP6                              # 42
* PI / MRF / ( ( MR03 GSBP8                                 # 51
- ( MR01 GSBP8 ) = tan-1 Min05 MR01                         # 60
M-03 MR02 sin sin-1 x>=0 GOTO2                              # 66
LBL1 MR03 x>=0 GOTO4                                        # 70
MR05 +/- GSBP7 GOTO4                                        # 74
LBL2 x=0 GOTO1                                              # 77
MR03 x>=0 GOTO3                                             # 80
MR05 GSBP7 GOTO4                                            # 83
LBL3 MR05 GSBP6                                             # 86
LBL4 6 0 * MR03 / MR05 cos =                                # 95
"D=#" HLT                                                   # 101
MR05 DMS<- "T=#"                                            # 108

*** P6
GSBP7 M+05 MR05                                             # 3

*** P7
+/- Min05 MRF M+05                                          # 4

*** P8
/ 2 + 4 5 ) tan ln                                          # 8

*** P9
Min09 INT + ( MR09 FRAC * 2 10^x )                          # 10
Min09 INT / 6 0 + MR09 FRAC / 3 6                           # 21
=                                                           # 22
