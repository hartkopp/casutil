# KW09 - Metropolis
# Kraftwerk, score for the Casio VL-80 pocket calculator (1981),
# converted for the FA-1/FA-2 by Claude Code
#
# The score gives only the keys of the VL-80 and no note lengths: each
# note is an eighth note (Min), each blank between the groups of the
# score an eighth rest (MinF). The comment behind a line gives the keys
# of the VL-80 ("#" the semitone key). The VL-80 plays G3..A5 with the
# keys = . 0 1..9 ÷ × - + (operation manual, Manual Play Function).
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The FX-501P/FX-502P version is in fx502/KW09.prg and KW09D.prg.
# Total 35
# @calculator 602
# @file all
# @name "KW09"
# @mode .20

*** P0
Min00 Min04 Min02 Min06 Min03 Min07 Min02 Min06    # keys [= 5 2 9 #2 #9 2 9 = 5 1 8 2 9 1 8]
Min00 Min04 Min01 Min05 Min02 Min06 Min01 Min05
MinF
Min00 Min04 Min02 Min06 Min03 Min07 Min02 Min06    # keys [= 5 2 9 #2 #9 2 9 = 5 1 8 2 9 1 8]
Min00 Min04 Min01 Min05 Min02 Min06 Min01 Min05 AC

*** Data

# Note data
M00  = 165  # G3
M01  = 123  # C4
M02  = 110  # D4
M03  = 103  # D#4
M04  = 82   # G4
M05  = 61   # C5
M06  = 54   # D5
M07  = 51   # D#5

# Tempo data, MF = 2 plays 120 quarter notes per minute
MF   = 2
