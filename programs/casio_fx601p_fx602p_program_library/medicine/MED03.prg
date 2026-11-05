# MED03 - Indication of red corpuscle
# Medicine-3, description see Program Library FX-601P/FX-602P, page 139 - 140
# prg code converted from the original document by Claude Code
#
# The comment behind a line is the step number of the program sheet,
# alpha text continued on the next line of the sheet is kept in one line.
# Total 78
# @calculator 602
# @name "MED03"
# @mode .20

*** P0
LBL1 GSBP1 ";C" HLT Min01                                   # 8
GSBP1 ";Hct" HLT Min02                                      # 15, 17
GSBP1 ";Hb" HLT Min03                                       # 25
"Vm=" PAUSE                                                 # 31
MR02 * 1 0 / MR01 = HLT                                     # 39
"Hm=" PAUSE                                                 # 45
/ MR02 * MR03 = HLT                                         # 51
"Hbm=" PAUSE                                                # 58
MR03 * 1 0 0 / MR02 = HLT                                   # 67
GOTO1                                                       # 68

*** P1
"INPUT "                                                    # 8
