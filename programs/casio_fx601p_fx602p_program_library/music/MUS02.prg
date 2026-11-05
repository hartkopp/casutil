# MUS02 - Für Elise
# Music-2, description see Program Library FX-601P/FX-602P, page 189 - 190
# prg code converted from the original document by Claude Code
#
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The comment behind a line is the step number of the program sheet.
# X<->M plays a 16th note, Min an eighth, MR a quarter, M- a half, M+ a
# whole note of the register, the register F a rest, - ties two notes.
# Total 220 (FX-602P only)
# @calculator 602
# @file all
# @name "MUS02"
# @mode .20

*** P9
Min09 Min18 Min09 Min18 Min09 Min06 Min08 Min07 MR05 MinF Min00 Min02 Min05 MR06 MinF  # 15

*** P8
GSBP9 Min02 Min16 Min06 MR07 MinF Min02 GSBP9 Min01 Min07 Min06             # 11

*** P7
MR09 - Min09 Min04 Min10 Min09 MR08 - Min08 Min03 Min09 Min08 MR07 - Min07 Min02 Min08 Min07 Min06 Min02 Min09 Min02 Min09 Min02 Min09  # 25
Min09 Min15 Min18 Min09 Min18 Min09 Min18 Min09 Min18 GSBP9 Min02 Min16 Min06 MR07 MinF Min02 GSBP9 Min01 Min07 Min06  # 45

*** P0
GSBP8 MR05 - Min05 MinF GSBP8 MR05 MinF Min06 Min07 Min08 GSBP7 MR05 MinF Min06 Min07 Min08 GSBP7 MR05 MinF Min07 Min07 Min07 M-07 MR10  # 25
- Min10 X<->M09 MR09 MR08 Min19 - X<->M19 X<->M12 Min12 Min11 Min10 Min09 Min08 Min07 MR17 MR05 X<->M05 X<->M04 X<->M05 X<->M17 M-07 Min08 Min18 MR09  # 50
- Min09 Min09 Min10 Min05 M-07 Min08 - X<->M08 X<->M06 X<->M07 X<->M11 X<->M04 X<->M11 X<->M05 X<->M11 X<->M06 X<->M11 X<->M07 X<->M11 X<->M08 X<->M11 X<->M09 X<->M11 X<->M14  # 75
X<->M13 X<->M12 X<->M11 X<->M10 X<->M09 X<->M08 X<->M11 X<->M10 X<->M08 X<->M07 X<->M11 X<->M04 X<->M11 X<->M05 X<->M11 X<->M06 X<->M11 X<->M07 X<->M11 X<->M08 X<->M11 X<->M09 X<->M11 X<->M14 X<->M13  # 100
X<->M12 X<->M11 X<->M10 X<->M09 X<->M08 X<->M11 X<->M10 X<->M08 X<->M09 X<->M10 X<->M09 X<->M18 X<->M09 X<->M06 X<->M09 X<->M18 X<->M09 X<->M06 X<->M09 X<->M18 MR09 - Min09 Min06 Min09  # 125
Min18 MR09 - Min09 Min06 Min09 Min18 Min09 Min18 Min09 Min18 GSBP8 MR05 MinF Min06 Min07 Min08 GSBP7 M+05 AC  # 145

*** Data

# Note data
M00  = 123  # do
M01  = 110  # re
M02  = 97   # mi
M03  = 92   # fa
M04  = 82   # sol
M05  = 72   # la
M06  = 64   # si
M07  = 61   # do
M08  = 54   # re
M09  = 48   # mi
M10  = 45   # fa
M11  = 40   # sol
M12  = 35   # la
M13  = 31   # si
M14  = 29   # do
M15  = 23   # mi
M16  = 77   # sol#
M17  = 68   # si flat
M18  = 51   # re#
M19  = 33   # si flat

# Tempo data, 4 - 5
MF   = 4
