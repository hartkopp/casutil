# STAT15 - 2-by-2 contingency table
# Statistics-15, description see Program Library FX-601P/FX-602P, page 125 - 126
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 86
# @calculator 602
# @name "STAT15"
# @mode .20

*** P0
"a" HLT Min01 "b"                                           # 8
HLT Min02 "c" HLT Min03 "d"                                 # 16, 18
HLT Min04                                                   # 20
MR01 Min05 MR03 M+05                                        # 24
MR02 Min06 MR04 M+06                                        # 28
MR01 Min07 MR02 M+07                                        # 32
MR03 Min08 MR04 M+08                                        # 36
MR05 Min09 MR06 M+09                                        # 40
GSBP1 GSBP2 "\*0=#" HLT                                      # 49
GSBP1 ABS - MR09 / 2 = GSBP2 "\*s=#"                         # 59, 63

*** P1
MR01 * MR04 - MR02 * MR03 =                                 # 8

*** P2
x^2 * MR09 / MR05 / MR06 / MR07 /                           # 10
MR08 =                                                      # 12
