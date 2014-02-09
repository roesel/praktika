set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right top #box
set fit errorvariables

name = '20g'

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output "../../gnuplot/10_lho_rezonance_".name.".pdf"


f(x)=a*(1/sqrt(((o**2-x**2)**2)+(4*l*(x**2))))
a=1
o=2
l=2
fit f(x) name.".txt" using 1:2 via a,o,l 

titulek1="Naměřené hodnoty"
titulek2=sprintf("g(f) = (%.1f\261%.1f) \267 sqrt( ((%.2f\261%.2f)^2-f^2)^2+(4\267(%.2f\261%.2f) \267 f^2) )^{-1}", a, a_err, o, o_err, l, l_err)

set size ratio 0.5

set xlabel "f [Hz]"
set ylabel "x [mm]"
set yrange [0.45:0.754]
set xrange [2.86:3.37]

plot name.".txt" with points title titulek1 lw 2 lt 1 lc rgb "red", f(x) lw 2 title titulek2

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###