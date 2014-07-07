set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right bottom #box
set key samplen 2 spacing .8 font "calibri,11"

set fit errorvariables

name='kalib'

set term pdfcairo font 'calibri,14' enhanced monochrome dashed size 6,4
set output name.".pdf"

titulek1="Hodnoty pro píky ^{137}Cs a ^{60}Co" 

f(x)= a*x #\pm 0.003421

fit f(x) name.".txt" using 1:2 via a

set xlabel "N [-]"
set ylabel "E_{tab} [keV]"

titulek2 = sprintf("f(x) = (%.3f\261%.3f) x ", a, a_err) 

set size ratio 0.5
#set samples 1000

set yrange [0:]
set xrange [0:]

plot name.".txt" using 1:2 title titulek1 lw 1 lt 1 lc rgb "red", f(x) title titulek2

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###