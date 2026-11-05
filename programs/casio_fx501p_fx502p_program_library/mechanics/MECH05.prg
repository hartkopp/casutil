# MECH05 - Beam fixed at both ends under concentrated load
# Mechanics-5, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mechanics-5
# prg code converted from the original document by Claude Code
#
# P2 leaves a parenthesis open, which P3 closes.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MECH05,
# the same program.
# The comment behind a line is the step number of the program sheet.
# The German edition of the FX-501P/FX-502P library has a version with
# 111 steps: without tan-1 for the angle and with the HLT in P3
# (MR5 ) = HLT) instead of behind each GSBP3. Its example shows
# -1.5625E-3 for the angle, the argument of tan-1, instead of
# -0.0895248 like the Japanese sheet and its formula, so tan-1 is
# missing there.
# Total 114 (the sheet says 113, the step numbers of the lines add up
# to 114)
# @calculator 502
# @number 205

*** P0
HLT * HLT = Min1 0 HLT Min2 HLT MinF HLT / MR2              # 13
x^y 3 = Min3 0 DEG                                          # 19
LBL1 HLT Min4 x>=F GOTO2 MRF Min8 MR4 Min9 GSBP1 GOTO1      # 30
LBL2 MR2 - MRF = Min8 MR2 - MR4 = Min9                      # 41
GSBP1 GOTO1                                                 # 43

*** P1
MR9 * ( MR2 + 2 * MR8 ) = Min4 MR2 *                        # 13
MR8 = Min5 MR3 * ( MR2 - MR8 ) x^2 =                        # 25
Min6 / 2 / MR1 * MR9 = Min7 / 3 * MR9                       # 38
GSBP2 3 * GSBP3 HLT                                         # 43
MR7 GSBP2 2 * GSBP3 tan-1 HLT                               # 50
MR6 GSBP2 GSBP3 HLT                                         # 54
MR6 * MR4 / MR9 =                                           # 60

*** P2
* ( MR4 -                                                   # 4

*** P3
MR5 ) =                                                     # 3
