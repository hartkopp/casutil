# KW04 - Neonlicht
# Kraftwerk, score for the Casio VL-80 pocket calculator (1981),
# converted for the FA-1/FA-2 by Claude Code
#
# The score gives only the keys of the VL-80 and no note lengths: each
# note is an eighth note (Min), each blank between the groups of the
# score an eighth rest (MinF). The comment behind a line gives the keys
# of the VL-80 ("#" the semitone key). The VL-80 plays G3..A5 with the
# keys = . 0 1..9 ÷ × - + (operation manual, Manual Play Function).
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The FX-501P/FX-502P version is in fx502/KW04.prg and KW04D.prg.
# Total 65
# @calculator 602
# @file all
# @name "KW04"
# @mode .20

*** P0
Min04 Min03 Min03 Min02 Min01 Min00 Min04 Min03    # keys [6 5 5 4 3 2 6 5 5 4 3 2 6 2 2 4 5 6 6 5 5]
Min03 Min02 Min01 Min00 Min04 Min00 Min00 Min02
Min03 Min04 Min04 Min03 Min03 MinF
Min04 Min03 Min03 Min02 Min01 Min00 Min04 Min03    # keys [6 5 5 4 3 2 6 5 5 4 3 2 6 2 2 4 5 6 6 5 5]
Min03 Min02 Min01 Min00 Min04 Min00 Min00 Min02
Min03 Min04 Min04 Min03 Min03 MinF
Min05 Min06 Min07 Min06 Min05 Min04 Min05 Min04    # keys [8 9 ÷ 9 8 6 8 6 5]
Min03 MinF
Min05 Min06 Min07 Min06 Min05 Min04 Min05 Min04    # keys [8 9 ÷ 9 8 6 8 6 9]
Min06 AC

*** Data

# Note data
M00  = 110  # D4
M01  = 97   # E4
M02  = 92   # F4
M03  = 82   # G4
M04  = 72   # A4
M05  = 61   # C5
M06  = 54   # D5
M07  = 48   # E5

# Tempo data, MF = 2 plays 120 quarter notes per minute
MF   = 2
