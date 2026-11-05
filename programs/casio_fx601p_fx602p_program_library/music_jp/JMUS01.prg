# JMUS01 - Sakura sakura (さくらさくら)
# Music-1 of the Japanese edition, description see Program Library
# FX-601P/FX-602P (Japanese edition), page 187 - 188
# prg code converted from the original document by Claude Code
#
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The comment behind a line is the step number of the program sheet.
# Min plays an eighth note, MR a quarter, M+ a whole note of the register.
# The point in front of a note marks a dotted note in the Japanese
# edition. The FX-601P/FX-602P manual says, that these calculators ignore
# the point, the English edition uses tied notes instead.
# Total 85
# @calculator 602
# @file all
# @name "JMUS01"
# @mode .20

*** P0
MR07 MR03 MR07 MR03 MR08 MR05 MR03 MR02                             # 8
MR07 MR03 MR07 MR03 MR08 MR05 MR03 MR02                             # 16
MR07 MR03 MR08 MR04 MR09 MR03 MR08                                  # 23
MR04                                                                # 24
MR07 MR04 MR08 MR07 MR06 MR01 MR04 MR06                             # 32
MR05 MR01 MR03 MR01 MR05 MR01 MR06 MR01                             # 40
MR05 MR01 MR05 MR03 MR02                                            # 45
MR05 MR03 MR02                                                      # 48
MR07 MR03 MR07 MR03 MR08 MR05 MR03 MR02                             # 56
MR07 MR03 MR07 MR03 MR08 MR05 MR03 MR02                             # 64
MR05 MR01 MR06                                                      # 67
MR01 MR08 MR07 MR06 MR04                                            # 72
M+05 Min01 Min02 Min03 Min05 Min06 Min07 Min08 . Min00              # 73, 82
M+10 AC                                                             # 84

*** Data

# Note data
M00  = 54   # re
M01  = 147  # la
M02  = 131  # si
M03  = 123  # do
M04  = 110  # re
M05  = 97   # mi
M06  = 92   # fa
M07  = 72   # la
M08  = 64   # si
M09  = 61   # do
M10  = 48   # mi

# Tempo data 6 - 8 as given by the Japanese edition. It refers to the tempo
# table 28..280 of the FX-501P/FX-502P (tempo code n plays (n + 1) * 28
# quarter notes per minute), so MF = 6 means 196 quarter notes per minute
# there. The FX-601P/FX-602P play (n + 1) * 40 quarter notes per minute
# (FX-602P manual, page 64), so the piece plays faster than intended. For
# the tempo of the Japanese edition, set MF to 4 - 5 instead.
MF   = 6
