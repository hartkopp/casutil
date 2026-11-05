# SURV01 - Addition, subtraction, multiplication and division of angles
# Surveying-1, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-1
# prg code converted from the original document by Claude Code
#
# Angles are entered as d.mmss (12.3456 for 12 34'56"). Press AC first,
# then P0 adds and P1 subtracts an angle, P2 is the = key for * and /
# (135.2 / 3 P2). The result is shown in the d.ms display. P9 converts
# d.mmss to degrees and leaves the parenthesis to close by the caller.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 44
# @calculator 502
# @number 401

*** P0
Min1 ( MR1 GSBP9 ) + DMS<-                                  # 7

*** P1
+/- GSBP0                                                   # 2

*** P2
Min1 X<->Y Min2 ( MR2 GSBP9 ) X<->Y = DMS<-                 # 10

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6                                  # 21
