# SURV28 - Simple curve
# Surveying-28, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-28
# prg code converted from the original document by Claude Code
#
# Input the intersection angle IA (d.mmss) and the radius R repeatedly;
# output the tangent length TL = R tan(IA / 2), the curve length
# CL = pi / 180 R IA and the external secant SL = R (sec(IA / 2) - 1),
# rounded to three decimals by P8. P9 converts d.mmss to degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 81
# @calculator 502
# @number 428

*** P0
AC DEG                                                      # 2
LBL1 HLT GSBP9 Min1 0 HLT Min2                              # 9
MR1 / 2 = tan * MR2 = GSBP8 HLT                             # 19
PI / 1 8 0 * MR1 * MR2 = GSBP8                              # 30
HLT                                                         # 31
MR1 / 2 = cos 1/x - 1 = * MR2 = GSBP8                       # 44
GOTO1                                                       # 45

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
