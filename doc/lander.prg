# Mondlandung (Lander), a moon landing game for the FX-602P
#
# Listing of the recording "19. Track 19.wav" of the FX-602P programs
# collected by Martin Krischik, https://fx-602p.krischik.com
# compared with the listing of the printer FP-10 at
# http://frickelfritze.bplaced.net/images/mondlandung.gif
#
# Two handwritten corrections of the printout are applied, marked with
# comments. Start the game with P0.
#
# @calculator 602
# @file program
# @name "Lander"
# @mode .20

*** P0
SAC
AC
Min02
Min03
Min04
3
Min14
Min17
LBL8
5
Min00
AC
Min11
1
M-14
GSBP1
LBL1
AC
MR02
M+07
MR04
+
9
.
8
*
MR07
=
Min03
+
MR04
=
/
2
*
MR07
=
M-01
GSBP6
MR15
x=0
GOTO6
GSBP7
MR03
Min04
FIX2
"V=#"
PAUSE
PAUSE
PAUSE
MR11
x=0
GSBP4
MR01
FIX0
"H=#"
PAUSE
PAUSE
PAUSE
"Fuel:\AR06"
PAUSE
PAUSE
PAUSE
MR17
x=0
GOTO2
GSBP3
"<\AR18/\->\AR19>"
HLT
AC
Min17
LBL2
MR06
x=0
GOTO1
x>=0
GSBP2
GOTO1
LBL6
"*\#\#*"
HLT
MR00
x=0
GOTO4
3
0
0
M-09
LBL4
0
-
MR01
=
ABS
*
1
0
=
INT
M-09
0
-
MR04
=
ABS
*
5
=
INT
M-09
4
0
0
M+09
RAN#
*
7
5
=
INT
+
MR12
=
Min01
0
Min02
Min04
Min07
MR14
x=0
GOTO5
GOTO8
LBL5
"END"
PAUSE
GSBP9
# 170 steps

*** P1
MR09
x=0
GOTO1
GOTO9
LBL1
3
10^x
MinF
"Hoehe?"
HLT
Min01
x>=F
GOTO1
2
0
0
MinF
MR01
x>=F
GOTO2
GOTO1
LBL2
Min01
Min12
Min10
LBL9
5
Min15
Min17
AC
RAN#
/
8
=
+/-
+
.
6
=
Min02
MR01
SQR
*
2
=
INT
+
1
0
=
Min06
RAN#
*
1
0
=
INT
M-06
RAN#
*
5
0
=
+
(
MR10
x^(1/y)
3
=
)
=
INT
M+10
RAN#
*
1
0
=
INT
/
1
0
=
M+10
# 92 steps

*** P2
AC
"Beam?"
HLT
x=0
GOTO1
Min05
M-06
MR06
x>=0
GOTO3
M+05
LBL3
MR05
M-04
MR07
x^(1/y)
9
=
-
.
5
=
M-07
LBL1
# 31 steps

*** P3
MR10
Min19
INT
Min18
MR19
FRAC
*
1
0
=
Min19
# 12 steps

*** P4
MR01
Min1F
-
5
=
MinF
MR18
x>=F
GOTO2
GOTO3
LBL2
MR1F
+
6
=
MinF
MR18
x>=F
GOTO3
"Right!"
PAUSE
9
9
-
MR03
ABS
=
INT
M+06
Min17
GSBP5
LBL3
# 40 steps

*** P5
LBL0
1
M+08
AC
"Turn?"
HLT
Min16
MR17
x=0
GOTO2
GSBP3
RAN#
*
8
=
INT
*
MR19
=
MinF
0
Min17
LBL2
MR16
x=F
GOTO3
DSZ
GOTO0
GOTO9
LBL3
"OKAY"
PAUSE # was HLT
5
5
M+06
MR00
+
1
=
*
3
0
=
M+09
"Bonus: #"
PAUSE
GOTO8
LBL9
"No"
PAUSE
LBL8
0
Min17
Min00
5
Min11
# 80 steps

*** P6
5
+/-
MinF
MR04
x>=F
GOTO1
GOTO9
LBL1
6
MinF
MR04
x>=F
GOTO9
7
+/-
MinF
MR01
x>=F
GOTO4
GOTO9
LBL4
7
MinF
MR01
x>=F
GOTO9
0
Min15
LBL9
# 30 steps

*** P7
5
+/-
MinF
MR01
x>=F
GOTO1
GSBP8
LBL1
# 9 steps

*** P8
LBL1
"\#ZR\#"
PAUSE
GSBP9
# 10 steps

*** P9
"Score:\AR09"
PAUSE
PAUSE
MR13
MinF
MR09
x=F
GOTO5
x>=F
GOTO2
GOTO5
LBL2
"!"
PAUSE
MR09
Min13 # High Score (was Min03 / fixed)
LBL5
"H-SC:\AR13\<-"
HLT
# 38 steps
