# SURV36 - Partition of a lot 1 (parallel to the opposite side)
# Surveying-36, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-36
# prg code converted from the original document by Claude Code
#
# Input the angles alpha and beta (d.mmss) at both ends of the side L,
# L and the area S repeatedly; output the length x of the dividing
# line parallel to L, x = sqrt(L^2 - 2S (cot alpha + cot beta)), and
# the side lengths a and b, rounded to three decimals by P8. P9
# converts d.mmss to degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 101
# @calculator 502
# @number 436

*** P0
DEG AC                                                      # 2
LBL1 HLT GSBP9 Min1 DMS<- HLT                               # 8
GSBP9 Min2 DMS<- HLT                                        # 12
Min3 0 HLT Min4                                             # 16
MR1 tan 1/x + MR2 tan 1/x = * 2 * MR4 -                     # 29
MR3 x^2 = +/- SQR Min5 GSBP8 HLT                            # 37
MR3 - MR5 = Min6 MR1 + MR2 = sin 1/x *                      # 49
MR6 = Min7 * MR2 sin = GSBP8 HLT                            # 58
MR7 * MR1 sin = GSBP8 GOTO1                                 # 65

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
