set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right top #box
set key samplen 2 spacing .8 font "calibri,11"

set fit errorvariables

name='unknown'

set term pdfcairo font 'calibri,14' enhanced monochrome dashed size 6,4
set output name.".pdf"

cal(x)= a*x
a = 0.657693

pi = 3.14

position        = 1277.16    #      +/- 1.113        (0.08715%)
sigma           = 37.8228    #      +/- 1.8          (4.76%)
amplitude       = 2150.06    #      +/- 141.6        (6.587%)
delta           = 10.1556    #      +/- 0.6903       (6.798%)

gauss(x)=amplitude/(sigma*sqrt(2.*pi))*exp(-(x-position)**2/(2.*sigma**2)) + delta

fit [1150:1350] gauss(x) name.".txt" using (cal($1)):($2) via position, sigma, amplitude, delta

titulek1 = name 
titulek2 = sprintf("position = (%.1f\261%.1f) x", position, position_err) 

#set xlabel "t [s]"
#set ylabel "x [cm]"

#set size ratio 0.5
#set samples 1000

#set yrange [-0.028:0.023]
set xrange [0:]

set style fill solid 1.0

plot name.".txt" using (cal($1)):($2) with boxes title titulek1 lw 1 lt 1 lc rgb "red", gauss(x) title titulek2

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###