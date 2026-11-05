# KW05 - Autobahn
# Kraftwerk, score for the Casio VL-80 pocket calculator (1981),
# converted for the FA-1/FA-2 by Claude Code
#
# The score gives only the keys of the VL-80 and no note lengths: each
# note is an eighth note (Min), each blank between the groups of the
# score an eighth rest (MinF). The comment behind a line gives the keys
# of the VL-80 ("#" the semitone key). The VL-80 plays G3..A5 with the
# keys = . 0 1..9 ÷ × - + (operation manual, Manual Play Function).
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The FX-501P/FX-502P version is in fx502/KW05.prg and KW05D.prg.
# Total 53
# @calculator 602
# @file all
# @name "KW05"
# @mode .20

*** P0
Min00 Min00 Min07 MinF                             # keys [4 4 ×]
Min07 Min00 Min00 Min07 MinF                       # keys [× 4 4 ×]
Min00 Min00 Min07 MinF                             # keys [4 4 ×]
Min07 Min00 Min00 Min07 MinF                       # keys [× 4 4 ×]
Min07 Min03 Min05 Min00 MinF                       # keys [× #6 8 4]
Min07 Min03 Min05 Min00 MinF                       # keys [× #6 8 4]
Min08 Min05 Min06 Min01 MinF                       # keys [- 8 9 5]
Min08 Min05 Min06 Min01 MinF                       # keys [- 8 9 5]
Min06 Min05 Min04 Min02 MinF                       # keys [9 8 7 6]
Min06 Min05 Min04 Min02 MinF                       # keys [9 8 7 6]
Min03 Min05 Min06 AC                               # keys [#6 8 9]

*** Data

# Note data
M00  = 92   # F4
M01  = 82   # G4
M02  = 72   # A4
M03  = 68   # A#4
M04  = 64   # B4
M05  = 61   # C5
M06  = 54   # D5
M07  = 45   # F5
M08  = 40   # G5

# Tempo data, MF = 2 plays 120 quarter notes per minute
MF   = 2
