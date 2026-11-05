# SURV15 - Area from coordinates
# Surveying-15, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Surveying-15
# prg code converted from the original document by Claude Code
#
# Input X and Y of the corners one after the other (the number of the
# next point is shown after each Y), then P1 gives the area
# S = |sum (X1 - Xi)(Y(i+1) - Y(i-1))| / 2. P4 adds one term.
# Not in the FX-601P/FX-602P program library.
# The comment behind a line is the step number of the program sheet.
# Total 56
# @calculator 502
# @number 415

*** P0
MAC 1 Min0                                                  # 3
HLT Min1 0                                                  # 6
HLT Min2 Min3 2 Min0                                        # 11
HLT Min4 0                                                  # 14
HLT Min5                                                    # 16
LBL1 ISZ MR0 HLT Min6 0                                     # 22
HLT Min7 GSBP4                                              # 25
MR5 Min3 MR6 Min4 MR7 Min5 GOTO1                            # 32

*** P1
MR2 Min7 GSBP4 MR8 ABS / 2 =                                # 8

*** P4
( MR1 - MR4 ) * ( MR7 - MR3 ) =                             # 12
M+8                                                         # 13
