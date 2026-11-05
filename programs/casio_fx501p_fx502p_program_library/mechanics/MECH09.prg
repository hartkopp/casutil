# MECH09 - Displacement, velocity and acceleration of the piston of a
#          piston-crank engine
# Mechanics-9, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Mechanics-9
# prg code converted from the original document by Claude Code
#
# Input r, l, theta and omega repeatedly; output displacement x,
# velocity v and acceleration a. FX-501P/FX-502P only, not in the
# FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 71
# @calculator 502
# @number 209

*** P0
DEG                                                         # 1
LBL1 HLT Min1 HLT Min2 HLT Min3 HLT Min4                    # 10
MR1 / MR2 = Min5 MR3 * 2 = Min6                             # 20
MR1 * ( 1 - MR3 cos - MR5 / 4 * MR6 cos                     # 34
) = HLT                                                     # 37
MR1 * MR4 * ( MR3 sin + MR5 / 2 * MR6                       # 50
sin ) = HLT                                                 # 54
MR1 * MR4 x^2 * ( MR3 cos + MR5 * MR6                       # 66
cos ) = GOTO1                                               # 70
