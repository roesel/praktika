set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right bottom #box
set key samplen 2 spacing .8 font "calibri,11"

set fit errorvariables

name='rozliseni'

set term pdfcairo font 'calibri,14' enhanced monochrome dashed size 6,4
set output name.".pdf"

fwmh(x) = 2*sqrt(2*log(2))*x

titulek1="Naměřené hodnoty" 

f(x)= a*x + b#\pm 0.003421

fit f(x) name.".txt" using 1:(fwmh($2)) via a, b

set xlabel 'E [keV]'
set ylabel '{/Symbol D} E [keV]'

titulek2 = sprintf("{/Symbol D}E(E) = (%.2f\261%.2f) E + (%.0f\261%.0f)", a, a_err, b, b_err) 

set size ratio 0.5
#set samples 1000

set yrange [0:]
set xrange [0:]

plot name.".txt" using 1:(fwmh($2)):(fwmh($3)) with yerrorbars title titulek1 lw 1 lt 1 lc rgb "red", f(x) title titulek2

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###