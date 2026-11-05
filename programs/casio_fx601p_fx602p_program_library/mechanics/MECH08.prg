# MECH08 - Forced vibration
# Mechanics-8, description see Program Library FX-601P/FX-602P, page 81 - 82
# prg code converted from the original document by Claude Code
#
# P1 leaves the multiplication open, which the caller completes.
# The comment behind a line is the step number of the program sheet.
# Total 125
# @calculator 602
# @name "MECH08"
# @mode .20

*** P0
MAC RAD "K?" HLT Min01                                      # 8
"W?" HLT Min02                                              # 14
"a?" HLT Min03                                              # 20
"w?" HLT Min04                                              # 26
"t0?" HLT MinF                                              # 33
"dt?" HLT Min05                                             # 40
MR01 * 9 8 0 / MR02 = SQR Min06                             # 50
* MR03 / ( MR06 x^2 - MR04 x^2 )                            # 60
* * MR04 = Min08 MR06 = Min09 AC                            # 69
LBL1 MR07 * MR04 GSBP1 MR09 = Min00 MR07 *                  # 79
MR06 GSBP1 MR08 = M-00                                      # 84
MR07 x>=F GOTO2 GSBP2 HLT MR05 M+07 GOTO1                   # 92
LBL2 GSBP2                                                  # 94

*** P1
= / 2 / PI = FRAC * 2 * PI = sin *                          # 14

*** P2
"t=#" PAUSE PAUSE                                           # 7
"x=" PAUSE PAUSE MR00                                       # 14
