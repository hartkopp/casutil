# KW06 - Computerliebe
# Kraftwerk, score for the Casio VL-80 pocket calculator (1981),
# converted for the FA-1/FA-2 by Claude Code
#
# The score gives only the keys of the VL-80 and no note lengths: each
# note is an eighth note (Min), each blank between the groups of the
# score an eighth rest (MinF). The comment behind a line gives the keys
# of the VL-80 ("#" the semitone key). The VL-80 plays G3..A5 with the
# keys = . 0 1..9 ÷ × - + (operation manual, Manual Play Function).
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The FX-501P/FX-502P version is in fx502/KW06.prg and KW06D.prg.
# Total 49
# @calculator 602
# @file all
# @name "KW06"
# @mode .20

*** P0
Min03 Min05 Min04 Min03 Min02 Min01 Min02 Min03    # keys [2 5 4 2 1 #. 1 2 =]
Min00 MinF
Min03 Min05 Min04 Min03 Min02 Min01 Min02 Min03    # keys [2 5 4 2 1 #. 1 2 =]
Min00 MinF
Min05 Min07 Min06 Min07 Min08 Min06 Min04 Min05    # keys [5 #6 6 #6 8 6 4 5]
MinF
Min05 Min09 Min07 Min08 Min05 Min07 Min08 Min04    # keys [5 9 #6 8 5 #6 8 4 #6]
Min07 MinF
Min05 Min07 Min06 Min07 Min08 Min06 Min04 Min05 AC # keys [5 #6 6 #6 8 6 4 5]

*** Data

# Note data
M00  = 165  # G3
M01  = 139  # A#3
M02  = 123  # C4
M03  = 110  # D4
M04  = 92   # F4
M05  = 82   # G4
M06  = 72   # A4
M07  = 68   # A#4
M08  = 61   # C5
M09  = 54   # D5

# Tempo data, MF = 2 plays 120 quarter notes per minute
MF   = 2
