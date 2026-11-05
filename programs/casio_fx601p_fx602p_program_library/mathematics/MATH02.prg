# MATH02 - Greatest common measure
# Mathematics-2, description see Program Library FX-601P/FX-602P, page 3 - 4
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 67
# @calculator 602
# @name "MATH02"
# @mode .20

*** P0
AC "INPUT <a>" HLT ABS Min01 MinF                           # 10, 16
AC "INPUT <b>" HLT ABS Min02                                # 26, 31
x>=F X<->M01 Min02                                          # 34
LBL1 MR01 / MR02 = INT * MR02 - MR01 =                      # 45
+/- x=0 GOTO2                                               # 48
X<->M02 Min01 GOTO1                                         # 51
LBL2 MR02 "<c>=#######"                                     # 60, 66
