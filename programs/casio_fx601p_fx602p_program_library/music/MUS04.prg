# MUS04 - Tarantella napoletana
# Music-4, description see Program Library FX-601P/FX-602P, page 195 - 196
# prg code converted from the original document by Claude Code
#
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The comment behind a line is the step number of the program sheet.
# Min plays an eighth note, MR a quarter note of the register, - ties two
# notes. The melody is in 6/8 time.
# Total 216 (FX-602P only)
# @calculator 602
# @file all
# @name "MUS04"
# @mode .20

*** P9
MR05 Min05 MR08 - Min08 MR05 - Min05 MR05 Min05 MR06 Min06 Min06    # 13
Min07 Min06 MR05 - Min05 Min05 Min06 Min05 MR05 Min04 Min04 Min05   # 25
Min04 MR04 Min03 Min03 Min04 Min03 MR03 Min02 Min02 Min03 Min02     # 36
MR01 - Min01 MR08 Min08 MR05 Min05 MR08 - Min08 MR05 - Min05 MR05   # 50
Min05 MR06 Min06 Min06 Min07 Min06 MR05 - Min05 Min05 Min06 Min05   # 62
MR05 Min04 Min04 Min05 Min04 MR04 Min03 Min03 Min04 Min03           # 72

*** P8
Min03 Min02 Min03 Min04 Min03 Min04 Min03 Min02 Min03 Min04 Min03   # 11
Min02 Min03 Min02 Min01 Min00 Min01 Min02 MR01 - Min01 MR01 Min02   # 23
Min03 Min02 Min03 Min04 Min03 Min04 Min05 Min04 Min05 Min06 Min05   # 34
Min04                                                               # 35

*** P7
Min03 Min02 Min03 Min05 Min11 Min05 MR07 Min07 Min07 Min08 Min07    # 11
MR07 Min06 Min06 Min07 Min06 MR06 Min05 Min10 Min01 Min02 Min03     # 22
Min02 Min03 Min05 Min11 Min05 MR07 Min07 Min07 Min12 Min07          # 32

*** P0
MR08 Min08 GSBP9 MR03 Min02 Min02 Min03 Min02 MR01 - Min01 MR01     # 12
Min02 GSBP8 Min03 Min02 Min01 Min00 Min01 Min02 MR01 - Min01 MR01   # 24
Min02 GSBP8 Min03 Min02 Min01 Min00 Min01 Min02 MR01 - Min01 MR08   # 36
Min08 GSBP9 MR03 Min02 Min02 Min03 Min02 MR01 - Min01 Min10 Min01   # 48
Min02 GSBP7 Min09 Min08 Min07 Min06 Min05 Min04 MR03 - Min03 Min10  # 60
Min01 Min02 GSBP7 Min09 Min08 Min07 Min06 Min05 Min04 MR03 - Min03  # 72
AC                                                                  # 73

*** Data

# Note data
M00  = 147  # la
M01  = 139  # si flat
M02  = 123  # do
M03  = 116  # re flat
M04  = 103  # mi flat
M05  = 92   # fa
M06  = 87   # sol flat
M07  = 77   # la flat
M08  = 68   # si
M09  = 61   # do
M10  = 156  # la flat
M11  = 97   # mi
M12  = 82   # sol

# Tempo data, 5 - 6
MF   = 5
