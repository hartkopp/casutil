# STAT08 - Binomial and Poisson distributions
# Statistics-8, description see Program Library FX-601P/FX-602P, page 111 - 112
# prg code converted from the original document by Claude Code
#
# P1 binomial, P2 Poisson distribution.
# The comment behind a line is the step number of the program sheet.
# Total 77
# @calculator 602
# @name "STAT08"
# @mode .20

*** P1
"n" HLT Min01 "x"                                           # 8
HLT Min02 "Px" HLT Min03                                    # 16
MR01 - MR02 = Min04                                         # 21
MR01 x! / MR02 x! / MR04 x! *                               # 30
MR03 x^y MR02 * ( 1 - MR03 ) x^y                            # 40
MR04 = "Px=#"                                               # 48

*** P2
"m" HLT Min01 "x"                                           # 8
HLT Min02                                                   # 10
MR01 +/- e^x * MR01 x^y MR02 / MR02                         # 19
x! = "Px=#"                                                 # 27
