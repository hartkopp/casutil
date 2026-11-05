# SURV37 - Partition of a lot 2 (one point fixed)
# Surveying-37, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-37
# prg code converted from the original document by Claude Code
#
# Input the angles alpha and beta (d.mmss) at both ends of the side L
# and L, then repeatedly the side a and the area S; output the side b,
# rounded to three decimals by P8. The previous a and S are shown as
# the default for the next input. P9 converts d.mmss to degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 117
# @calculator 502
# @number 437

*** P0
MAC DEG AC                                                  # 3
HLT GSBP9 Min1 DMS<- HLT GSBP9 Min2                         # 10
DMS<- HLT Min3                                              # 13
LBL1 MR4 HLT Min4 MR5 HLT Min5                              # 20
MR3 x^2 + MR4 x^2 - 2 * MR3 *                               # 30
MR4 * MR1 cos = SQR Min7                                    # 37
MR5 - MR3 * MR4 * MR1 sin / 2 =                             # 48
* 2 / MR7 / ( MR2 - ( ( MR3                                 # 59
x^2 + MR7 x^2 - MR4 x^2 ) / 2                               # 69
/ MR3 / MR7 ) cos-1 ) sin = GSBP8                           # 79
HLT GOTO1                                                   # 81

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x )
Min9 INT / 6 0 + MR9 FRAC / 3 6
=                                                           # 22
