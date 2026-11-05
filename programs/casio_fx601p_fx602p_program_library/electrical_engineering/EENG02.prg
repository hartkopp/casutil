# EENG02 - Impedance of series and parallel circuits
# Electrical engineering-2, description see Program Library FX-601P/FX-602P,
# page 35 - 36
# prg code converted from the original document by Claude Code
#
# P1..P4 input R, C, L and f, P0 calculates the series circuit, P5 the
# parallel circuit.
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 128
# @calculator 602
# @name "EENG02"
# @mode .20

*** P0
"Series"                                                    # 8
PAUSE MR01 Min06                                            # 11
MR05 * MR03 - MR05 1/x / MR02                               # 19
GSBP6                                                       # 20

*** P5
"Paralle." MR05 * MR02 - MR05 1/x /                         # 8, 17
MR03 = Min08                                                # 20
x^2 + MR01 1/x x^2 = Min09                                  # 27
* MR01 = 1/x Min06                                          # 32
MR08 +/- / MR09 GSBP6                                       # 37

*** P6
= Min07 "x" PAUSE MR06 HLT                                  # 8
R->P "y" PAUSE MR07 HLT                                     # 15
"Z" PAUSE = HLT                                             # 21
"Phase"                                                     # 28
PAUSE X<->Y                                                 # 30

*** P1
"R" PAUSE Min01                                             # 5

*** P2
"C" PAUSE EXP 6 +/- Min02                                   # 8

*** P3
"L" PAUSE EXP 3 +/- Min03                                   # 8

*** P4
"2\PIf" PAUSE Min04                                         # 7
* 2 * PI = Min05                                            # 13
