# KW01 - Der Taschenrechner
# Kraftwerk, score for the Casio VL-80 pocket calculator (1981),
# converted for the FA-1/FA-2 by Claude Code
#
# The score gives only the keys of the VL-80 and no note lengths: each
# note is an eighth note (Min), each blank between the groups of the
# score an eighth rest (MinF). The comment behind a line gives the keys
# of the VL-80 ("#" the semitone key). The VL-80 plays G3..A5 with the
# keys = . 0 1..9 ÷ × - + (operation manual, Manual Play Function).
# The raised point between 8 and 4 in the first line of the score is
# taken as a smudge, the same group in the second line has none.
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The FX-501P/FX-502P version is in fx502/KW01.prg and KW01D.prg.
# Total 75
# @calculator 602
# @file all
# @name "KW01"
# @mode .20

*** P0
Min01 Min02 Min06 Min06 MinF                       # keys [4 5 9 9]
Min05 Min01 Min02 Min05 Min05 Min04 MinF           # keys [8 4 5 8 8 7]
Min01 Min02 Min06 Min06 MinF                       # keys [4 5 9 9]
Min05 Min01 Min02 Min05 Min05 Min04 Min03 MinF     # keys [8 4 5 8 8 7 6]
Min01 Min02 Min06 Min06 MinF                       # keys [4 5 9 9]
Min05 Min01 Min02 Min05 Min05 Min04 MinF           # keys [8 4 5 8 8 7]
Min01 Min02 Min06 Min06 MinF                       # keys [4 5 9 9]
Min05 Min01 Min02 Min05 Min05 Min04 Min03 MinF     # keys [8 4 5 8 8 7 6]
Min01 Min01 Min00 Min05 Min01 MinF                 # keys [4 4 2 8 4]
Min01 Min01 Min00 Min05 Min01 MinF                 # keys [4 4 2 8 4]
Min01 Min01 Min00 Min05 Min01 MinF                 # keys [4 4 2 8 4]
Min01 Min01 Min00 Min05 Min01 AC                   # keys [4 4 2 8 4]

*** Data

# Note data
M00  = 110  # D4
M01  = 92   # F4
M02  = 82   # G4
M03  = 72   # A4
M04  = 64   # B4
M05  = 61   # C5
M06  = 54   # D5

# Tempo data, MF = 2 plays 120 quarter notes per minute
MF   = 2
