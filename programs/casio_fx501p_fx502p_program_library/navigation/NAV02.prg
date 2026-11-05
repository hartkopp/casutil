# NAV02 - Great circle navigation
# Navigation-2, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Navigation-2
# prg code converted from the original document by Claude Code
#
# Input N1, E1, N2 and E2 (d.ms) repeatedly; output distance D and
# course T (d.ms). P9 converts an angle d.ms to degrees.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library NAV02,
# with prompts and alpha output, same formulas, but without loop.
# The comment behind a line is the step number of the program sheet.
# Total 101 (the Japanese sheet says 104, the step numbers of the lines
# add up to 101, the German edition says 101)
# @calculator 502
# @number 502

*** P0
DEG HLT                                                     # 2
LBL1 GSBP9 Min1 0 HLT GSBP9 Min2 0 HLT GSBP9                # 12
Min3 0 HLT GSBP9 Min4                                       # 17
- MR2 = Min5                                                # 21
MR1 sin * MR3 sin + MR1 cos * MR3 cos * MR5                 # 34
cos = cos-1 Min6 * 6 0 = Min7 HLT                           # 44
( MR3 sin - MR1 sin * MR6 cos ) / MR6 sin /                 # 58
MR1 cos = cos-1 Min8                                        # 63
MR5 sin x>=0 GOTO2 3 6 0 -                                  # 71
LBL2 MR8 = DMS<- HLT GOTO1                                  # 77

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22
