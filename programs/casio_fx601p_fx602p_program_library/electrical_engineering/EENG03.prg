# EENG03 - Impedance of series resonance circuit
# Electrical engineering-3, description see Program Library FX-601P/FX-602P,
# page 37 - 38
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet.
# Total 127
# @calculator 602
# @name "EENG03"
# @mode .20

*** P0
"R1" HLT Min01                                              # 6
"R2" HLT Min02                                              # 12
"C" HLT EXP 6 +/- Min03                                     # 20
"L" HLT EXP 3 +/- Min04                                     # 28
* MR03 = SQR * 2 * PI = 1/x                                 # 38
RND4 MinF                                                   # 40
"f0=#" PAUSE                                                # 47
"f" HLT * 2 * PI = Min05                                    # 57
* MR04 - MR05 1/x / MR03 = Min06                            # 66
MR01 + MR02 = Min07 x^2 + MR06 x^2                          # 75
= Min00                                                     # 77
MR01 * ( MR02 * MR07 + MR06 x^2 )                           # 87
/ MR00 =                                                    # 90
"x" PAUSE Min08 HLT                                         # 96
R->P ( MR01 x^2 * MR06 / MR00 )                             # 105
"y" PAUSE Min09 HLT                                         # 111
"Z" PAUSE = HLT                                             # 117
"Phase"                                                     # 124
PAUSE X<->Y                                                 # 126
