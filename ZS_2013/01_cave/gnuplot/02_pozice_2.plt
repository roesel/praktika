set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right top #box
set key samplen 2 spacing .8 font "calibri,11"

set fit errorvariables

name='data_2'

set term pdfcairo font 'calibri,14' enhanced monochrome dashed size 6,4
set output name.".pdf"

f(x)=a*exp(-1*l*x)*cos(o*x+h)+d
a = 25
o = 0.013
d = 104.6
h = 10
l = 0.0005

fit f(x) name.".txt" using 1:2 via a,o,h,d,l

titulek1="Naměřené hodnoty" 
titulek2 = sprintf("f(t) = (%.2f\261%.2f) e^{-(%.5f\261%.5f)t} cos( (%.5f\261%.5f)t + (%.3f\261%.3f) ) + (%.2f\261%.2f)", a, a_err, l, l_err, o, o_err, h, h_err, d, d_err ) 

set xlabel "t [s]"
set ylabel "x [cm]"

set size ratio 0.5
set samples 1000

#set yrange [-0.028:0.023]
#set xrange [2.8:7.7]

plot name.".txt" using 1:2:3 with yerrorbars title titulek1 lw 1 lt 1 lc rgb "red", f(x) lt 1 lw 2 title titulek2 

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###