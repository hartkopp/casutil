# MUS06 - Tarantella napoletana (ナポリタン・タランテラ)
# Music-6, description see Program Library FX-501P/FX-502P
# (Japanese edition), sheet Music-6 (marked "for FX-502P")
# prg code converted from the original document by Claude Code
#
# Program part, the note and tempo data are in MUS06D. The FX-501P/
# FX-502P save program and data separately: load both, set the FA-1 to
# MUSIC, start the tape recorder and press P0.
# X<->M plays a 16th note, Min an eighth, MR a quarter note of the
# register. The point in front of a note makes it a dotted note.
# FX-601P/FX-602P version: casio_fx601p_fx602p_program_library MUS04,
# the same melody and note data (M10..M12 instead of M.0..M.2), but with
# tied notes (-) instead of dotted notes and with eighth notes instead of
# the 16th notes in P0. The German edition of the FX-501P/FX-502P library
# has the same version (Musik-4, 202 steps) with other line ends.
# Errors of the sheet: in 6/8 time the figure . MR1 MR1 Min2 fills a
# bar like in P8, the 16th notes X<->M2 at steps 12 and 23 of P0 make it
# a 16th note short. The German edition and the 602 version have eighth
# notes there. The listing follows the sheet, a line with "fix:" behind
# the step number is split at the error and "fix:" gives its
# replacement. The 16th notes in front of GSBP7 (steps 45 and 57) are
# kept in the German edition, the 602 version has eighth notes there too.
# The comment behind a line is the step number of the program sheet.
# Total 202
# @calculator 502
# @number 606

*** P9
MR5 Min5 . MR8 . MR5 MR5 Min5 MR6 Min6 Min6 Min7 Min6 . MR5 Min5 Min6 Min5 MR5 Min4 Min4 Min5 Min4 MR4 Min3  # 25
Min3 Min4 Min3 MR3 Min2 Min2 Min3 Min2 . MR1 MR8 Min8 MR5 Min5 . MR8 . MR5 MR5 Min5 MR6 Min6 Min6 Min7 Min6  # 50
. MR5 Min5 Min6 Min5 MR5 Min4 Min4 Min5 Min4 MR4 Min3 Min3 Min4 Min3  # 65

*** P8
Min3 Min2 Min3 Min4 Min3 Min4 Min3 Min2 Min3 Min4 Min3 Min2 Min3 Min2 Min1 Min0 Min1 Min2 . MR1 MR1 Min2 Min3 Min2 Min3  # 25
Min4 Min3 Min4 Min5 Min4 Min5 Min6 Min5 Min4                # 34

*** P7
Min3 Min2 Min3 Min5 Min.1 Min5 MR7 Min7 Min7 Min8 Min7 MR7 Min6 Min6 Min7 Min6 MR6 Min5 Min.0 Min1 Min2 Min3 Min2 Min3 Min5  # 25
Min.1 Min5 MR7 Min7 Min7 Min.2 Min7                         # 32

*** P0
MR8 Min8 GSBP9 MR3 Min2 Min2 Min3 Min2 . MR1 MR1            # 11
X<->M2                                                      # 12 fix: Min2
GSBP8 Min3 Min2 Min1 Min0 Min1 Min2 . MR1 MR1               # 22
X<->M2                                                      # 23 fix: Min2
GSBP8 Min3                                                  # 25
Min2 Min1 Min0 Min1 Min2 . MR1 MR8 Min8 GSBP9 MR3 Min2 Min2 Min3 Min2 . MR1 Min.0 Min1 X<->M2 GSBP7 Min9 Min8 Min7 Min6  # 50
Min5 Min4 . MR3 Min.0 Min1 X<->M2 GSBP7 Min9 Min8 Min7 Min6 Min5 Min4 . MR3 AC  # 67
