# NAV03 - Rhumb line navigation
# Navigation-3, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Navigation-3
# prg code converted from the original document by Claude Code
#
# Input N1, E1, N2 and E2 (d.ms) repeatedly; output distance D and
# course T (d.ms). P9 converts an angle d.ms to degrees, P6..P8 are
# subroutines; P8 closes a parenthesis.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library NAV03,
# with prompts and alpha output, same formulas, but without loop and
# with the labels 1..4 instead of 2..5 here.
# The comment behind a line is the step number of the program sheet.
# Total 123
# @calculator 502
# @number 503

*** P0
DEG HLT                                                     # 2
LBL1 MAC GSBP9 X<->M1 HLT GSBP9 X<->M2 HLT                  # 10
GSBP9 X<->M3 HLT GSBP9 M-2 1 8 0 MinF                       # 19
MR2 ABS x>=F GSBP6 * PI / MRF /                             # 28
( ( MR3 GSBP8 - ( MR1 GSBP8 ) = tan-1                       # 39
Min5 MR1 M-3 MR2 sin sin-1 x>=0 GOTO3                       # 47
LBL2 MR3 x>=0 GOTO5                                         # 51
MR5 +/- GSBP7 GOTO5                                         # 55
LBL3 x=0 GOTO2                                              # 58
MR3 x>=0 GOTO4                                              # 61
MR5 GSBP7 GOTO5                                             # 64
LBL4 MR5 GSBP6                                              # 67
LBL5 6 0 * MR3 / MR5 cos = HLT MR5 DMS<- HLT GOTO1          # 81

*** P6
GSBP7 M+5 MR5                                               # 3

*** P7
+/- Min5 MRF M+5                                            # 4

*** P8
/ 2 + 4 5 ) tan ln                                          # 8

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22
