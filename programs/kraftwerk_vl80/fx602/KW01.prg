# KW01 - Der Taschenrechner
# Kraftwerk, score for the Casio VL-80 pocket calculator (1981),
# converted for the FA-1/FA-2 by Claude Code
#
# The notes follow the score, the keys of the VL-80 are in the comment
# behind each line ("#" the semitone key, the VL-80 plays G3..A5 with
# the keys = . 0 1..9 ÷ × - +, see its operation manual). The score has
# no note lengths. The lengths of lines 1 and 2 (1/8, 1/4 and the
# dotted 3/8) are taken from the melody track "8-Bit Square" of the
# MIDI file "Kraftwerk - Pocket Calculator (the Mix, New Instruments)",
# beats 71.75 to 102.25 at 132 quarter notes per minute: there the
# groups 4599 845887 have the rhythm of the phrase 45949 845887 (the
# extra 4 lengthens the 9 in front of it), the groups 4599 8458876 that
# of the phrase 4599 8458876; short grace notes of the MIDI file are
# left out. Each line of the score is two such phrases (4 bars of 4/4).
# Line 3 (44284, four times) is not in the MIDI file, its notes are
# eighth notes with an eighth rest (MinF) behind each group, a quarter
# rest (MRF) separates it from line 2.
# The raised point between 8 and 4 in the first line of the score is
# taken as a smudge, the same group in the second line has none.
# The dotted 3/8 is a quarter tied to an eighth (MR - Min).
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The FX-501P/FX-502P version is in fx502/KW01.prg and KW01D.prg.
# Total 80
# @calculator 602
# @file all
# @name "KW01"
# @mode .20

*** P0
Min01 Min02 MR06 MR06 - Min06                      # keys [4 5 9 9] 1/8 1/8 1/4 3/8
Min05 Min01 Min02 MR05 Min05 MR04 - Min04          # keys [8 4 5 8 8 7] 1/8 1/8 1/8 1/4 1/8 3/8
Min01 Min02 MR06 MR06 - Min06                      # keys [4 5 9 9] 1/8 1/8 1/4 3/8
Min05 Min01 Min02 MR05 Min05 MR04 Min03            # keys [8 4 5 8 8 7 6] 1/8 1/8 1/8 1/4 1/8 1/4 1/8
Min01 Min02 MR06 MR06 - Min06                      # keys [4 5 9 9] 1/8 1/8 1/4 3/8
Min05 Min01 Min02 MR05 Min05 MR04 - Min04          # keys [8 4 5 8 8 7] 1/8 1/8 1/8 1/4 1/8 3/8
Min01 Min02 MR06 MR06 - Min06                      # keys [4 5 9 9] 1/8 1/8 1/4 3/8
Min05 Min01 Min02 MR05 Min05 MR04 Min03            # keys [8 4 5 8 8 7 6] 1/8 1/8 1/8 1/4 1/8 1/4 1/8
MRF                                                # quarter rest in front of line 3
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
