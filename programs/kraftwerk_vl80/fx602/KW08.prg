# KW08 - Das Model
# Kraftwerk, score for the Casio VL-80 pocket calculator (1981),
# converted for the FA-1/FA-2 by Claude Code
#
# The score gives only the keys of the VL-80 and no note lengths: each
# note is an eighth note (Min), each blank between the groups of the
# score an eighth rest (MinF). The comment behind a line gives the keys
# of the VL-80 ("#" the semitone key). The VL-80 plays G3..A5 with the
# keys = . 0 1..9 ÷ × - + (operation manual, Manual Play Function).
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The FX-501P/FX-502P version is in fx502/KW08.prg and KW08D.prg.
# Total 80
# @calculator 602
# @file all
# @name "KW08"
# @mode .20

*** P0
Min02 Min02 Min04 Min02 Min04 Min02 Min00 MinF     # keys [6 6 8 6 8 6 3]
Min00 Min01 Min00 Min01 MinF                       # keys [3 5 3 5]
Min02 Min02 Min04 Min02 Min04 Min02 Min00 MinF     # keys [6 6 8 6 8 6 3]
Min00 Min01 Min00 Min01 MinF                       # keys [3 5 3 5]
Min00 Min02 Min02 Min02 Min04 Min03 Min02 Min03    # keys [3 6 6 6 8 7 6 7 5 3]
Min01 Min00 MinF
Min00 Min02 Min02 Min02 Min04 Min03 Min02 Min03    # keys [3 6 6 6 8 7 6 7 5 3]
Min01 Min00 MinF
Min00 Min02 Min02 Min02 Min04 Min03 Min02 Min03    # keys [3 6 6 6 8 7 6 7 5 3]
Min01 Min00 MinF
Min00 Min02 Min02 Min02 Min04 Min03 Min02 Min03    # keys [3 6 6 6 8 7 6 7 5 3]
Min01 Min00 MinF
Min04 Min03 Min02 Min01 MinF                       # keys [8 7 6 5]
Min04 Min03 Min05 AC                               # keys [8 7 ÷]

*** Data

# Note data
M00  = 97   # E4
M01  = 82   # G4
M02  = 72   # A4
M03  = 64   # B4
M04  = 61   # C5
M05  = 48   # E5

# Tempo data, MF = 2 plays 120 quarter notes per minute
MF   = 2
