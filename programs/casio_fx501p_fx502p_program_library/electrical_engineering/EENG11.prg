# EENG11 - Transistor amplifier
# Electrical engineering-11-1 and 11-2, description see Program Library
# FX-501P/FX-502P (Japanese edition), sheets Electrical engineering-11-1
# (P0..P3, P9, P8) and 11-2 (P4)
# prg code converted from the original document by Claude Code
#
# P0 input of the h parameters, P1..P3 conversion of hb, he and hc, P4
# impedances and gains. On the FX-501P only parts fit: hb conversion
# P0, P1, P9; he conversion P0, P2, P8, P9; hc conversion P0, P3, P8.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library EENG11,
# with prompts and alpha output, same results; there the conversions
# are table driven with the subroutines P6 and P7.
# Errors of the sheet, also in the German edition of the FX-501P/FX-502P
# library. The listing follows the sheet, a line with "fix:" behind the
# step number is split at the error and "fix:" gives its replacement:
# - P8 line 1: MR3 +/- outputs -h21, the conversion table of the sheet
#   needs -(1 + h21) = MR6 +/-.
# - P4 line 2: ( MR4 / MR8 1/x ) calculates h22 * Ze, the formula for Zi
#   needs h22 + 1/Ze = ( MR4 + MR8 1/x ). The example of the sheet was
#   calculated with the error: Zi = 7.218E-4, correct is 0.035910447.
# The fixes keep the number of steps. The correct version is
# casio_fx601p_fx602p_program_library EENG11 (P6 and P4).
# The comment behind a line is the step number of the program sheet.
# Total 249
# @calculator 502
# @number 161

*** P0
EXP 3 Min1 HLT Min2 HLT Min3 HLT EXP 6 +/- Min4 *            # 13
MR1 - MR2 * MR3 = Min5 1 + MR3 = Min6                       # 25

*** P1
LBL0 HLT GSBP0 0 HLT                                        # 5
LBL2 GSBP9 GOTO0                                            # 8
LBL3 MR1 / MR6 / 3 10^x = HLT 1 HLT MR6 1/x                 # 21
+/- HLT MR4 / MR6 * 6 10^x = GOTO0                          # 31

*** P2
LBL0 HLT GSBP0 0 HLT                                        # 5
LBL1 GSBP9 GOTO0                                            # 8
LBL3 GSBP8 GOTO0                                            # 11

*** P3
LBL0 HLT GSBP0 0 HLT                                        # 5
LBL1 MR1 / MR3 = +/- / 3 10^x = HLT ( MR5 +                 # 19
MR3 ) / MR3 = +/- HLT MR6 / MR3 = +/- HLT                   # 32
MR4 / MR3 = +/- * 6 10^x = GOTO0                            # 42
LBL2 GSBP8 GOTO0                                            # 45

*** P9
MR1 / MR6 / 3 10^x = HLT ( MR5 - MR2                        # 12
) / MR6 = HLT MR3 / MR6 = +/- HLT MR4 /                     # 25
MR6 * 6 10^x =                                              # 30

*** P8
MR1 / 3 10^x = HLT 1 - MR2 = HLT                            # 11
MR3 +/-                                                     # 13 fix: MR6 +/-
HLT MR4 * 6 10^x =                                          # 19

*** P4
LBL0 HLT GSBP0 0 HLT EXP 3 Min7 HLT EXP 3 Min8              # 12
( MR5 + MR1 / MR8 ) / ( MR4                                 # 22
/ MR8                                                       # 24 fix: + MR8
1/x ) / 3 10^x = HLT                                        # 31
( MR1 + MR7 ) / ( MR5 + MR4 * MR7                           # 43
) / 3 10^x = HLT                                            # 49
MR3 * MR8 / ( MR1 + MR5 * MR8 ) = +/-                       # 62
Min9 HLT                                                    # 64
MR3 / MR8 / ( MR4 + MR8 1/x ) = +/- HLT                     # 77
* MR9 = GOTO0                                               # 81
