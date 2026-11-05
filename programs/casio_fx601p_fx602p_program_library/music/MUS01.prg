# MUS01 - Ogonek
# Music-1, description see Program Library FX-601P/FX-602P, page 187 - 188
# prg code converted from the original document by Claude Code
#
# Set the FA-1/FA-2 to MUSIC, start the tape recorder and press P0.
# The comment behind a line is the step number of the program sheet.
# Min plays an eighth note, MR a quarter, M- a half note of the register.
# Total 106
# @calculator 602
# @file all
# @name "MUS01"
# @mode .20

*** P9
Min00 Min03 Min05 Min07 Min09 Min03 Min08 Min07 Min09 Min03 Min04 Min08     # 12
Min08 Min03 Min04 Min06 Min08 Min03 Min06 Min07 Min08 Min03 Min06           # 23
Min07 Min05                                                                 # 25

*** P0
GSBP9 Min02 Min03 Min05 Min07 Min05 Min03 Min02 Min00 Min03 Min09 Min10     # 12
Min11 Min04 Min10 Min09 Min11 Min03 Min06 Min10 Min10 Min05 Min08 Min05     # 24
Min10 Min05 Min10 Min11 Min12 Min05 Min11 Min12 Min09 Min03 Min04 Min06     # 36
Min09 Min08 Min06 Min04 Min00 Min07 Min14 Min14 Min14 Min07 Min13           # 47
Min12 Min14 Min07 Min09 Min13 Min10 Min05 Min08 Min05 Min10 Min05 Min10     # 59
Min11 Min12 Min05 Min11 Min12 Min09 Min04 Min07 Min09 Min01 Min04 Min06     # 71
Min09 GSBP9 Min07 Min09 Min07 MR05 M-12 AC                                  # 79

*** Data

# Note data
M00  = 147  # la
M01  = 131  # si
M02  = 123  # do
M03  = 97   # mi
M04  = 77   # sol#
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

# Tempo data
MF   = 3
