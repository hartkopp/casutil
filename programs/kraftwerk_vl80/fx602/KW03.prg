# KW03 - Radioaktivität
# Kraftwerk, score for the Casio VL-80 pocket calculator (1981),
# converted for the FA-1/FA-2 by Claude Code
#
# The score gives only the keys of the VL-80 and no note lengths: each
# note is an eighth note (Min), each blank between the groups of the
# score an eighth rest (MinF). The comment behind a line gives the keys
# of the VL-80 ("#" the semitone key). The VL-80 plays G3..A5 with the
# keys = . 0 1..9 ÷ × - + (operation manual, Manual Play Function).
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The FX-501P/FX-502P version is in fx502/KW03.prg and KW03D.prg.
# Total 61
# @calculator 602
# @file all
# @name "KW03"
# @mode .20

*** P0
Min03 Min06 Min06 Min03 Min06 Min03 MinF           # keys [3 6 6 3 6 3]
Min06 Min08 Min07 Min06 MinF                       # keys [6 8 7 6]
Min01 Min04 Min04 Min01 Min04 Min01 MinF           # keys [1 4 4 1 4 1]
Min04 Min06 Min05 Min04 MinF                       # keys [4 6 5 4]
Min03 Min06 Min06 Min03 Min06 Min03 MinF           # keys [3 6 6 3 6 3]
Min06 Min08 Min07 Min06 MinF                       # keys [6 8 7 6]
Min01 Min04 Min04 Min01 Min04 Min01 MinF           # keys [1 4 4 1 4 1]
Min04 Min06 Min05 Min04 MinF                       # keys [4 6 5 4]
Min00 Min01 Min01 Min00 Min01 Min00 MinF           # keys [= 1 1 = 1 =]
Min01 Min03 Min02 Min01 AC                         # keys [1 3 2 1]

*** Data

# Note data
M00  = 165  # G3
M01  = 123  # C4
M02  = 110  # D4
M03  = 97   # E4
M04  = 92   # F4
M05  = 82   # G4
M06  = 72   # A4
M07  = 64   # B4
M08  = 61   # C5

# Tempo data, MF = 2 plays 120 quarter notes per minute
MF   = 2
