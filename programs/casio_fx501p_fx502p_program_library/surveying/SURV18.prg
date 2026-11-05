# SURV18 - Closed traverse (closing error, precision, adjustment)
# Surveying-18, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-18 (marked "for FX-502P")
# prg code converted from the original document by Claude Code
#
# Closed or connecting traverse, adjusted by the compass rule: input XA,
# YA, for a connecting traverse XB and YB (for a closed traverse EXE
# directly), the azimuth alpha0, then the angle theta and distance l of
# each line; the azimuth is shown. P1 shows the closing errors sum dx,
# sum dy, the sum of the distances and the precision, then theta and l
# are entered once more and the adjusted dx, dy and the coordinates X,
# Y are shown. P2 calculates a line, P4 subtracts 360, P8 rounds to
# three decimals, P9 converts d.mmss to degrees.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 171
# @calculator 502
# @number 418

*** P0
DEG MAC 3 6 0 MinF AC                                       # 7
HLT Min7 0                                                  # 10
HLT Min8                                                    # 12
MR7 HLT - MR7 = +/- Min4                                    # 19
MR8 HLT - MR8 = +/- Min5 0                                  # 27
HLT GSBP9 Min1 Min0 DMS<- HLT                               # 33
LBL1 GSBP2 MR2 M+6                                          # 37
MR1 DMS<- HLT GOTO1                                         # 41

*** P2
GSBP9 Min2 DMS<-                                            # 3
HLT X<->M2 + MR1 + 1 8 0 =                                  # 12
x>=F GSBP4 x>=F GSBP4 Min1                                  # 17
MR2 P->R MR1 = Min3 X<->Y GSBP8 M+5                         # 25
X<->M3 GSBP8 M+4                                            # 28

*** P4
- MRF =                                                     # 3

*** P1
MR4 HLT x^2 + MR5 HLT x^2 = SQR 1/x *                       # 11
MR6 HLT = X<->M0 Min1 MR4 X<->M.4 Min4                      # 19
MR5 X<->M.5 Min5 MR0 HLT                                    # 24
LBL2 GSBP2 MR2 / MR6 * Min2 MR.4 +/- + MR4 =                # 36
GSBP8 Min4 HLT                                              # 39
MR2 * MR.5 +/- + MR5 = GSBP8 Min5 HLT                       # 49
MR4 + MR7 = HLT MR5 + MR8 = HLT GOTO2                       # 60

*** P8
* 3 10^x + FRAC = INT / 3 10^x =                            # 11

*** P9
Min9 INT + ( MR9 FRAC * 2 10^x ) Min9                       # 11
INT / 6 0 + MR9 FRAC / 3 6 =                                # 22
