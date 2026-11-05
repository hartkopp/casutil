# MECH03 - Simple beam under concentrated load
# Mechanics-3, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mechanics-3
# prg code converted from the original document by Claude Code
#
# Input E, I, l, a and P, then x repeatedly; output deflection y, slope,
# moment M and shearing force Ws (Ws is shown at the HLT behind LBL1).
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MECH03,
# with alpha output in P3..P6.
# Error of the sheet, also in the German edition of the FX-501P/FX-502P
# library. The listing follows the sheet, a line with "fix:" behind the
# step number is split at the error and "fix:" gives its replacement:
# - P1 line 3: the slope formula of the sheet lacks the factor 1/l
#   (P(l-a)/6EI instead of P(l-a)/6EIl), so the program multiplies with
#   MR3 (l) and the example shows -11.3099324, correct is -0.28647651.
# With the fix the following step numbers are 2 lower. The correct
# version is casio_fx601p_fx602p_program_library MECH03 (P1 line 3).
# The comment behind a line is the step number of the program sheet.
# Total 87
# @calculator 502
# @number 203

*** P0
HLT Min1 HLT Min2 HLT Min3 HLT MinF HLT Min4 DEG            # 11
LBL1 HLT Min5 x>=F GOTO2 GOTO3                              # 17
LBL2 MRF +/- Min8 MR5 - MR3 = GSBP1 GOTO1                   # 27
LBL3 MR3 - MRF = Min8 MR5 GSBP1 GOTO1                       # 36

*** P1
Min9 MR4 * MR8 / MR3 = Min6 / 6 / MR1 /                     # 13
MR2 = Min7 * MR9 * ( GSBP2 HLT                              # 22
MR7 * MR3                                                   # 25 fix: MR7
* ( 3 * GSBP2 tan-1 HLT                                     # 32
MR6 * MR9 = HLT MR6                                         # 38

*** P2
MR9 x^2 + MR8 x^2 - MR3 x^2 ) =                             # 10
