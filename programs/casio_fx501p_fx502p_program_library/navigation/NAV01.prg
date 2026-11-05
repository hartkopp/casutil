# NAV01 - Astronomical observation
# Navigation-1, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Navigation-1
# prg code converted from the original document by Claude Code
#
# Input P, D/h and t/A (d.ms) repeatedly; output h/D and A/t (d.ms).
# P9 converts an angle d.ms to degrees.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library NAV01,
# with prompts and alpha output, same formulas, but without loop.
# The comment behind a line is the step number of the program sheet.
# Total 92
# @calculator 502
# @number 501

*** P0
DEG HLT                                                     # 2
LBL1 GSBP9 Min1 0 HLT GSBP9 Min2 0 HLT                      # 11
GSBP9 Min3                                                  # 13
MR1 sin * MR2 sin + MR1 cos * MR2 cos * MR3                 # 26
cos = sin-1 Min4 DMS<- HLT                                  # 32
( MR2 sin - MR1 sin * MR4 sin ) / MR1 cos /                 # 46
MR4 cos = cos-1 Min5                                        # 51
MR3 sin x>=0 GOTO3 MR5 GOTO4                                # 57
LBL3 3 6 0 - MR5 =                                          # 64
LBL4 DMS<- HLT GOTO1                                        # 68

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22
