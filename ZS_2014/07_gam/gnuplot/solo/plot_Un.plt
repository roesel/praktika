set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
#set grid x y
set key on inside right top #box
set key samplen 2 spacing .8 font "calibri,11"

set fit errorvariables

name='Un'

set term pdfcairo font 'calibri,14' enhanced monochrome dashed size 6,4
set output name.".pdf"

pi = 3.14

cal(x)= a*x
a = 0.657693


titulek1 = 'spektrum neznámého zářiče'

unset label
set label "539,3\2610,2"  at first  539+30, first  300 font "Calibri,11"
set label "1277\2611"  at first  1277-80, first 60 font "Calibri,11"
 
set xlabel 'E [keV]'
set ylabel 'N [-]'

set size ratio 0.5
#set samples 1000

set yrange [0:]
set xrange [0:4000*a]

set style fill solid 1.0

plot name.".txt" using (cal($1)):($2-$3) with boxes title titulek1 lw 1 lt 1 lc rgb "#0066FF"#, gauss1(x) title titulek_zpet, gauss(x) title titulek2
#plot name.".txt" using (cal($1)):($2) with boxes title titulek1 lw 1 lt 1 lc rgb "#0066FF"#, gauss(x) title titulek2

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###