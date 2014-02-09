set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right bottom #box
set fit errorvariables

name='04_10g'

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output "../../gnuplot/10_pohl_dekr_".name.".pdf"

f(x)=a*exp(-1*l*x)*cos(o*x+h)
a=0.0762384
l=0.0489291
o=3.53963
h=-15.8896
fit f(x) name.".txt" using 1:2 via a,l,o,h

titulek1="Naměřené hodnoty"
titulek2 = sprintf("f(t) = (%.3f\261%.3f) e^{-(%.3f\261%.3f)t} cos( (%.3f\261%.3f)t + (%.2f\261%.2f) ) )", a, a_err, l, l_err, o, o_err, h, h_err )

set xlabel "t [s]"
set ylabel "x [m]"

set size ratio 0.5
set samples 1000

set yrange [-0.1:0.1]
set xrange [5.6:20.6]

set pointsize 0.5
plot name.".txt" with points title titulek1 lw 1 lt 1 lc rgb "red", f(x) lw 2 lt 3 title titulek2

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###