# JMUS03 - Kojo no tsuki (荒城の月)
# Music-3 of the Japanese edition, description see Program Library
# FX-601P/FX-602P (Japanese edition), page 191 - 192
# prg code converted from the original document by Claude Code
#
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The comment behind a line is the step number of the program sheet.
# Min plays an eighth note, M- a half note of the register.
# Total 121
# @calculator 602
# @file all
# @name "JMUS03"
# @mode .20

*** P9
Min07 Min09 Min07                                                   # 3

*** P8
Min05 Min07 Min05                                                   # 3

*** P7
Min09 Min05 Min09 Min05 Min12 Min07 Min13 Min08 Min14 Min07 Min13   # 11
Min08 Min12 Min07 Min08 Min09                                       # 16

*** P0
Min09 Min05 Min09 Min05 Min11 Min09 Min12 Min13 Min14 Min07 Min13   # 11
Min08 Min12 GSBP9                                                   # 14
Min11 Min05 Min08 Min05 Min09 Min04 Min06 Min09 Min12 GSBP9         # 24
Min02 GSBP9                                                         # 26
GSBP7                                                               # 27
Min11 Min05 Min11 Min05 Min09 Min04 Min08 Min04 Min09 GSBP8 Min01   # 38
GSBP8                                                               # 39
GSBP7                                                               # 40
Min11 Min05 Min08 Min05 Min09 Min04 Min06 Min09 Min05 GSBP9 Min02   # 51
GSBP9                                                               # 52
Min07 Min03 Min05 Min07 Min06 Min03 Min05 Min03 Min11 Min05 Min11   # 63
Min05 Min09 GSBP8                                                   # 66
Min08 Min05 Min09 Min05 Min11 Min05 Min08 Min11 Min09 GSBP8 Min01   # 77
GSBP8                                                               # 78
GSBP7                                                               # 79
Min11 Min05 Min08 Min05 Min09 Min04 Min06 Min09 Min05 GSBP9 Min02   # 90
Min08 Min09 Min11                                                   # 93
M-12 AC                                                             # 95

*** Data

# Note data
M01  = 197  # mi
M02  = 147  # la
M03  = 97   # mi
M04  = 77   # sol#
M05  = 72   # la
M06  = 64   # si
M07  = 61   # do
M08  = 54   # re
M09  = 48   # mi
M11  = 45   # fa
M12  = 35   # la
M13  = 31   # si
M14  = 29   # do, a semitone above 31

# Tempo data 3 - 4 as given by the Japanese edition. It refers to the tempo
# table 28..280 of the FX-501P/FX-502P (tempo code n plays (n + 1) * 28
# quarter notes per minute), so MF = 3 means 112 quarter notes per minute
# there. The FX-601P/FX-602P play (n + 1) * 40 quarter notes per minute
# (FX-602P manual, page 64), so the piece plays faster than intended. For
# the tempo of the Japanese edition, set MF to 2 - 3 instead.
MF   = 3
