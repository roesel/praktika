set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right bottom #box
set fit errorvariables

name='40g_2'

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output "../../gnuplot/10_lho_tlum_".name.".pdf"

f(x)=a*exp(-1*l*x)*cos(o*x+h)+d
a=15
l=1
o=13
h=8
d=31
fit f(x) name.".txt" using 1:2 via a,l,o,h,d

titulek1="Naměřené hodnoty"
titulek2 = sprintf("f(t) = (%.2f\261%.2f) e^{-(%.2f\261%.2f)t} cos( (%.2f\261%.2f)t + (%.2f\261%.2f) )", a, a_err, l, l_err, o, o_err, h, h_err )

set xlabel "t [s]"
set ylabel "x [m]"

set size ratio 0.5
set samples 1000

set yrange [-0.045:0.045]
set xrange [4.1:8.5]

plot name.".txt" with points title titulek1 lw 2 lt 1 lc rgb "red", f(x) lw 2 title titulek2

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###