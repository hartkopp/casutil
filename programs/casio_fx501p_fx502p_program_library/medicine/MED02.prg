# MED02 - Removal of urea
# Medicine-2, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Medicine-2
# prg code converted from the original document by Claude Code
#
# Input Vt, U, B and BSA (0 if not corrected); output Cm and <Cm> or
# Cs and <Cs>. P1 is a subroutine.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MED01,
# with prompts and alpha output, same formulas; here the input is done
# with MAC and X<->M (the display shows 0 after each input), there with
# Min.
# The comment behind a line is the step number of the program sheet.
# Total 55
# @calculator 502
# @number 352

*** P0
LBL0 MAC HLT X<->MF HLT X<->M2 HLT X<->M3 HLT Min4          # 10
x=0 GOTO1 1 . 7 3 / MR4 * MRF = MinF HLT                    # 23
LBL1 2 x>=F GOTO2 GSBP1 1 . 3 3 = GOTO0                     # 34
LBL2 MRF SQR MinF GSBP1 1 . 8 5 = GOTO0                     # 45

*** P1
MR2 * MRF / MR3 = HLT *                                     # 8
