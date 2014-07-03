reset

set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
#set grid x y
set key on inside right bottom vertical maxrows 2 #box
set fit errorvariables

name = 'stefpyro'

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output name.'.pdf'

set yrange [1800:2800]
set xrange [1800:2800]
set xlabel "T_{pyro} [K]"
set ylabel "T_{stef} [K]"

set samples 1000
set size ratio 0.5

plot name.'.txt' using 1:3:2:4 with xyerrorbars title "Naměřené hodnoty" lc rgb "red"

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###