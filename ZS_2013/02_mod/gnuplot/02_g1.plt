set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right bottom #box
set key samplen 2 spacing .8 font "calibri,11"

set fit errorvariables

name='data_g1'

set term pdfcairo font 'calibri,14' enhanced monochrome dashed size 6,4
set output name.".pdf"

f(x) = (x-b)/a#a*x+b
a = 0.22
b = -5.48E-3
#fit f(x) name.".txt" using 1:3  via a,b

titulek1="Zatěžování"
titulek2="Odlehčování" 
titulek3 = "f'(x) = (0,22)x-(5,48 \267 10^{-3})"  

set xlabel "M [N \267 m]"
set ylabel "{/Symbol D}{/Symbol f}_{(1,2)} [rad]"

set size ratio 0.5
set samples 1000

#set yrange [-0.028:0.023]
#set xrange [2.8:7.7]

plot name.".txt" using 1:3 title titulek1 lw 1 lt 1 lc rgb "red", name.".txt" using 1:5 title titulek2 lw 1 lt 2 lc rgb "blue", f(x) lt 2 lw 1 title titulek3 

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###