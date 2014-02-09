set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right top #box
set key samplen 2 spacing .8 font "calibri,11"

set fit errorvariables

name='data'

set term pdfcairo font 'calibri,14' enhanced monochrome dashed size 6,4
set output name.".pdf"

f(x) = a*x+b
fit f(x) name.".txt" using 1:2 via a,b 

titulek1="Spočítané hodnoty {/Symbol K}"
titulek2 = sprintf("f(t) = (%.2f\261%.2f) t + (%.2f\261%.2f)", a, a_err, b, b_err )

set xlabel "t [s]"
set ylabel "{/Symbol K} [-]"

set xrange [0:]
set size ratio 0.5
set samples 1000

plot name.".txt" using 1:2 title titulek1 lw 1 lt 1 lc rgb "red", name.".txt" using 1:5 title titulek2 lw 1 lt 2 lc rgb "blue", f(x) lt 2 lw 1 title titulek2 

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###