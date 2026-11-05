# SURV06 - Inverse calculation (single, radial)
# Surveying-6, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-6
# prg code converted from the original document by Claude Code
#
# Input XA, YA, then XB, YB; output the distance l (rounded to three
# decimals by P8) and the azimuth alpha (d.ms, 0 <= alpha < 360). For
# further single lines start again with P0, for further points B from
# the same point A (radial) input XB, YB again.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 56
# @calculator 502
# @number 406

*** P0
DEG AC                                                      # 2
HLT Min1 0                                                  # 5
HLT Min2 0 HLT                                              # 9
LBL1 Min3 0                                                 # 12
HLT Min4 ( MR3 - MR1 ) R->P                                 # 20
( MR4 - MR2 ) = Min5 X<->Y x>=0 GOTO2                       # 30
+ 3 6 0 =                                                   # 35
LBL2 X<->M5 GSBP8 HLT MR5 DMS<- HLT GOTO1                   # 43

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11
