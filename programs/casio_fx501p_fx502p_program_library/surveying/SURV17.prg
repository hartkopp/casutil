# SURV17 - Closed traverse (angle closing error)
# Surveying-17, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-17
# prg code converted from the original document by Claude Code
#
# Input the interior angles (d.mmss) of the closed traverse one after the
# other, then P1 shows the sum, the closing error against (n - 2) * 180,
# the correction per angle in whole seconds and the remainder (d.ms).
# The remainder is adjusted at the lines in the directions 45, 135, 225
# and 315 degrees. P9 converts d.mmss to degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 75
# @calculator 502
# @number 417

*** P0
MAC AC HLT                                                  # 3
LBL1 GSBP9 Min9 M+1                                         # 7
1 M+0 MR9 DMS<- HLT GOTO1                                   # 13

*** P1
MR1 DMS<- HLT                                               # 3
MR0 - 2 = * 1 8 0 = M-1 MR1 DMS<- HLT                       # 16
/ MR0 * 3 6 0 0 Min9 = INT                                  # 26
/ MR9 = DMS<- HLT                                           # 31
* MR0 = M-1 MR1 DMS<-                                       # 37

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22
