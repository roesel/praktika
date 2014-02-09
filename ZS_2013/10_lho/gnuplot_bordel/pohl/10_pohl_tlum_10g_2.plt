set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right bottom #box
set fit errorvariables

name='10g_2'

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output "../../gnuplot/10_pohl_tlum_".name.".pdf"

f(x)=a*exp(-1*l*x)*cos(o*x+h)+d
a=0.08
l=0.048
o=3.54
h=14.86
d=0.003
fit f(x) name.".txt" using 1:2 via a,l,o,h,d

titulek1="Naměřené hodnoty"
titulek2 = sprintf("f(t) = (%.3f\261%.3f) e^{-(%.3f\261%.3f)t} cos( (%.3f\261%.3f)t + (%.2f\261%.2f) )", a, a_err, l, l_err, o, o_err, h, h_err )

set xlabel "t [s]"
set ylabel "x [m]"

set size ratio 0.5
set samples 1000

set yrange [-0.12:0.12]
set xrange [7:45]

set pointsize 0.5
plot name.".txt" with points title titulek1 lw 1 lt 1 lc rgb "red", f(x) lw 2 lt 3 title titulek2

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###