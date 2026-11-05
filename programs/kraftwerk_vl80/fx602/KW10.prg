# KW10 - Trans Europa Express
# Kraftwerk, score for the Casio VL-80 pocket calculator (1981),
# converted for the FA-1/FA-2 by Claude Code
#
# The score gives only the keys of the VL-80 and no note lengths: each
# note is an eighth note (Min), each blank between the groups of the
# score an eighth rest (MinF). The comment behind a line gives the keys
# of the VL-80 ("#" the semitone key). The VL-80 plays G3..A5 with the
# keys = . 0 1..9 ÷ × - + (operation manual, Manual Play Function).
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The FX-501P/FX-502P version is in fx502/KW10.prg and KW10D.prg.
# Total 35
# @calculator 602
# @file all
# @name "KW10"
# @mode .20

*** P0
Min00 Min01 Min04 Min03 MinF                       # keys [5 #5 #8 8]
Min00 Min01 Min03 Min02 MinF                       # keys [5 #5 8 #6]
Min00 Min01 Min04 Min03 Min02 Min03 MinF           # keys [5 #5 #8 8 #6 8]
Min00 Min01 Min04 Min03 MinF                       # keys [5 #5 #8 8]
Min00 Min01 Min03 Min02 MinF                       # keys [5 #5 8 #6]
Min00 Min01 Min04 Min03 Min02 Min03 AC             # keys [5 #5 #8 8 #6 8]

*** Data

# Note data
M00  = 82   # G4
M01  = 77   # G#4
M02  = 68   # A#4
M03  = 61   # C5
M04  = 57   # C#5

# Tempo data, MF = 2 plays 120 quarter notes per minute
MF   = 2
