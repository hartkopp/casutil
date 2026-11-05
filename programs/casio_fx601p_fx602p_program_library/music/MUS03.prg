# MUS03 - Romance de amor
# Music-3, description see Program Library FX-601P/FX-602P, page 191 - 194
# prg code converted from the original document by Claude Code
#
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The comment behind a line is the step number of the program sheet.
# Min plays an eighth note, M+ a whole note of the register, - ties two
# notes. P1..P9 play the accompaniment of the melody notes in P0.
# Total 215 (P1..P9 on page 192, P0 on page 194, FX-602P only)
# @calculator 602
# @file all
# @name "MUS03"
# @mode .20

*** P1
Min16 Min13                                                                   # 2

*** P2
Min03 Min01                                                                   # 2

*** P3
Min04 Min12                                                                   # 2

*** P4
Min16 Min14                                                                   # 2

*** P5
Min16 Min17                                                                   # 2

*** P6
Min14 Min10                                                                   # 2

*** P7
Min15 Min03                                                                   # 2

*** P8
Min03 Min11                                                                   # 2

*** P9
Min12 Min14                                                                   # 2

*** P0
Min07 GSBP1 Min07 GSBP1 Min07 GSBP1 Min07 GSBP1 Min06 GSBP1 Min05 GSBP1 Min05 GSBP1 Min04 GSBP1 Min03 GSBP1 Min03 GSBP1 Min05 GSBP1 Min07 GSBP1  # 24
Min00 GSBP1 Min00 GSBP1 Min00 GSBP1 Min00 GSBP1 Min09 GSBP1 Min08 GSBP1 Min08 GSBP2 Min07 GSBP2 Min06 GSBP2 Min06 GSBP2 Min07 GSBP2 Min08 GSBP2  # 48
Min07 GSBP3 Min08 GSBP3 Min07 GSBP3 Min19 GSBP3 Min08 GSBP3 Min07 GSBP3 Min07 GSBP1 Min06 GSBP1 Min05 GSBP1 Min05 GSBP1 Min04 GSBP1 Min03 GSBP1  # 72
Min04 GSBP4 Min04 GSBP4 Min04 GSBP4 Min04 GSBP4 Min05 GSBP4 Min04 GSBP4 Min03 GSBP1 Min03 GSBP1 Min03 GSBP1 M+03 - Min03 Min15 GSBP5  # 95
Min15 GSBP5 Min15 GSBP5 Min15 GSBP5 Min04 GSBP5 Min03 GSBP5 Min03 GSBP6 Min12 GSBP6 Min12 GSBP6 Min12 GSBP6 Min02 GSBP6 Min12 GSBP6 Min18  # 118
GSBP3 Min18 GSBP3 Min18 GSBP3 Min18 GSBP3 Min19 GSBP3 Min18 GSBP3 Min18 GSBP7 Min07 GSBP7 Min07 GSBP7 Min07 GSBP7 Min18 GSBP7 Min19 GSBP7  # 141
Min00 GSBP7 Min00 GSBP7 Min00 GSBP7 Min00 GSBP7 Min19 GSBP7 Min09 GSBP7 Min18 GSBP8 Min18 GSBP8 Min18 GSBP8 Min18 GSBP8 Min07 GSBP8 Min06 GSBP8  # 165
Min15 GSBP9 Min15 GSBP9 Min15 GSBP9 Min15 GSBP9 Min06 GSBP9 Min04 GSBP9 Min03 GSBP5 Min03 GSBP5 Min03 GSBP5 M+03 - Min03 AC  # 187

*** Data

# Note data
M00  = 35   # la
M01  = 92   # fa
M02  = 80   # fa* (fa#)
M03  = 72   # la
M04  = 64   # si
M05  = 61   # do
M06  = 54   # re
M07  = 48   # mi
M08  = 45   # fa
M09  = 40   # sol
M10  = 131  # si
M11  = 87   # fa#
M12  = 77   # sol#
M13  = 123  # do
M14  = 110  # re
M15  = 57   # do#
M16  = 97   # mi
M17  = 116  # do#
M18  = 42   # fa#
M19  = 37   # sol#

# Tempo data, 4 - 5
MF   = 4
