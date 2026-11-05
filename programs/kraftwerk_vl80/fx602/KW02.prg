# KW02 - Computerwelt
# Kraftwerk, score for the Casio VL-80 pocket calculator (1981),
# converted for the FA-1/FA-2 by Claude Code
#
# The score gives only the keys of the VL-80 and no note lengths: each
# note is an eighth note (Min), each blank between the groups of the
# score an eighth rest (MinF). The comment behind a line gives the keys
# of the VL-80 ("#" the semitone key). The VL-80 plays G3..A5 with the
# keys = . 0 1..9 ÷ × - + (operation manual, Manual Play Function).
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The FX-501P/FX-502P version is in fx502/KW02.prg and KW02D.prg.
# Total 59
# @calculator 602
# @file all
# @name "KW02"
# @mode .20

*** P0
Min04 Min01 Min00 Min02 MinF                       # keys [5 2 0 3]
Min04 Min01 Min00 Min02 MinF                       # keys [5 2 0 3]
Min07 Min04 Min02 Min05 MinF                       # keys [8 5 3 6]
Min04 Min01 Min00 Min02 MinF                       # keys [5 2 0 3]
Min04 Min05 Min06 MinF                             # keys [5 6 #6]
Min06 Min05 Min03 Min04 Min01 MinF                 # keys [#6 6 4 5 2]
Min04 Min05 Min06 MinF                             # keys [5 6 #6]
Min06 Min05 Min03 Min04 MinF                       # keys [#6 6 4 5]
Min04 Min05 Min06 MinF                             # keys [5 6 #6]
Min06 Min05 Min03 Min04 Min01 MinF                 # keys [#6 6 4 5 2]
Min04 Min05 Min06 MinF                             # keys [5 6 #6]
Min06 Min05 Min03 Min04 AC                         # keys [#6 6 4 5]

*** Data

# Note data
M00  = 131  # B3
M01  = 110  # D4
M02  = 97   # E4
M03  = 92   # F4
M04  = 82   # G4
M05  = 72   # A4
M06  = 68   # A#4
M07  = 61   # C5

# Tempo data, MF = 2 plays 120 quarter notes per minute
MF   = 2
