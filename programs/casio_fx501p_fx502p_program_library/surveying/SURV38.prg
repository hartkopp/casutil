# SURV38 - Partition of a lot 3 (angle fixed)
# Surveying-38, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-38 (marked "for FX-502P")
# prg code converted from the original document by Claude Code
#
# Input the angles alpha and beta (d.mmss) at both ends of the side L,
# L and the area S, then repeatedly the angle gamma of the dividing
# line; output the length x of the dividing line and the side lengths
# a and b, rounded to three decimals by P8. Not for a pair of interior
# angles on one side that add up to 180 degrees. P9 converts d.mmss to
# degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 162
# @calculator 502
# @number 438

*** P0
DEG AC                                                      # 2
HLT GSBP9 Min1 DMS<- HLT GSBP9 Min2                         # 9
DMS<- HLT Min3 0 HLT Min4                                   # 15
LBL1 HLT GSBP9 Min5                                         # 19
MR1 + MR2 - MR5 = Min6                                      # 26
1 8 0 - MR6 = Min7                                          # 33
MR3 * MR2 sin / MR7 sin = Min7                              # 42
MR1 - MR5 = Min8                                            # 47
MR4 - MR3 * MR7 * MR8 sin / 2 =                             # 58
Min8                                                        # 59
MR7 x^2 - 2 * MR8 * ( MR5 cos /                             # 70
MR5 sin + MR6 cos / MR6 sin ) = SQR                         # 81
Min8 GSBP8 HLT                                              # 84
MR8 M-7                                                     # 86
MR7 / ( MR5 + MR6 ) sin Min.1 *                             # 96
MR6 sin = GSBP8 HLT                                         # 101
MR3 * MR1 sin / ( 1 8 0 - MR5 )                             # 113
sin = - MR8 = * MR5 sin / MR.1 =                            # 124
GSBP8 GOTO1                                                 # 126

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x )                            # 10
Min9 INT / 6 0 + MR9 FRAC / 3 6                             # 21
=                                                           # 22

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
