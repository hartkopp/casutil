# STAT20 - Multiple correlation coefficient
# Statistics-20, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Statistics-20
# prg code converted from the original document by Claude Code
#
# P0 data input (x1, x2, y), P1 result, P2 subroutine.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library STAT19,
# with prompts and alpha output, same formulas, M10..M16 instead of
# M.0..M.6 and the counters M17, M18 instead of M0.
# The comment behind a line is the step number of the program sheet.
# Total 125
# @calculator 502
# @number 320

*** P0
MAC                                                         # 1
LBL1 ISZ MR0 HLT Min1 M+4 x^2 M+3 0 HLT                     # 11
Min2 M+6 x^2 M+5 AC HLT xD * * MR1 = M+.1                   # 23
MR2 = M+.2 MR1 * MR2 = M+.3 GOTO1                           # 32

*** P1
MR.3 Min.0 MR4 Min1 MR6 Min2 MR3 MinF                       # 8
MR5 Min0 GSBP2 Min.4                                        # 12
MR.1 Min.0 MR8 Min2 MR7 Min0 GSBP2 Min.5                    # 20
MR.2 Min.0 MR6 Min1 MR5 MinF GSBP2 Min.6                    # 28
1 - ( 1 + 2 * MR.4 * MR.5 * MR.6 -                          # 41
MR.4 x^2 - MR.5 x^2 - MR.6 x^2 ) /                          # 51
( 1 - MR.4 x^2 ) = SQR                                      # 59

*** P2
( MR9 * MR.0 - MR1 * MR2 ) /                                # 10
( ( MR9 * MRF - MR1 x^2 ) *                                 # 20
( MR9 * MR0 - MR2 x^2 ) ) SQR =                             # 31
