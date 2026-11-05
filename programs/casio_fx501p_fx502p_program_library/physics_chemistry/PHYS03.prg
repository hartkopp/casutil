# PHYS03 - Thermal conduction through layers
# Physics/chemistry-3, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Physics/chemistry-3
# prg code converted from the original document by Claude Code
#
# Input x and y, then l and k of each layer (up to 6), then T0 and Tn;
# output heat flow q and the temperatures between the layers.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library PHYS03,
# with prompts and alpha output, same formulas. The loop end differs:
# here MF = M0 + 1 and LBL4 ISZ x=F, there MF = M00 and
# LBL4 ISZ MR00 x=F. The German edition of the FX-501P/FX-502P library
# has the same program.
# The comment behind a line is the step number of the program sheet.
# Total 73
# @calculator 502
# @number 253

*** P0
LBL2 MAC HLT Min1 0 HLT * MR1 = Min9 0                      # 11
LBL3 HLT Min7 0 HLT Min8 ISZ                                # 18
MR7 / MR8 / MR9 = IND Min0 M+F                              # 27
6 - MR0 = x=0 GOTO1 GOTO3                                   # 34
LBL1 0 HLT Min7 0 HLT Min8 ( MR7 - MR8 ) / MRF              # 48
= Min9 HLT                                                  # 51
MR0 + 1 = MinF 0 Min0                                       # 58
LBL4 ISZ x=F GOTO2                                          # 62
MR7 - MR9 * IND MR0 = Min7 HLT GOTO4                        # 72
