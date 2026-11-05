# BANK09 - Calculation of aggregate classification and prorating
# Banking-9, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Banking-9
# prg code converted from the original document by Claude Code
#
# P0 input of code number and data repeatedly, P1 total, then the sum
# and ratio of each code and the total of the ratios; P4 subroutine.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library BANK08,
# with prompts and alpha output, same algorithm; here the total is added
# up in the display during the input (+ ... P1 0 =), there P1 adds up
# the registers.
# The comment behind a line is the step number of the program sheet.
# Total 57
# @calculator 502
# @number 459

*** P0
MAC AC                                                      # 2
LBL1 HLT Min0 x>=F MinF 0                                   # 8
HLT IND M+0 + GOTO1                                         # 13

*** P1
0 = HLT / 4 10^x = X<->M1 GSBP4                             # 9
X<->M2 GSBP4 M+2 2 Min0 x=F GOTO2                           # 16
LBL1 ISZ IND MR0 GSBP4 M+2                                  # 22
MR0 x=F GOTO2 GOTO1                                         # 26
LBL2 MR2                                                    # 28

*** P4
HLT / MR1 + . 5 = INT / 2 10^x = HLT                        # 13
