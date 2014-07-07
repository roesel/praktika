reset

set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside top left #box
set fit errorvariables

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4

name='c'

pi = 3.14159265359
D = 4.825*10**3
B = 0.460*10**3
A = 0.262*10**3

f(x) = 8*pi*A*D*D*x/(c*(D+B))
fit f(x) name.".txt" using 1:2 via c

set samples 1000
set size ratio 0.5
#set format x "%.2f"
set format y "%.2f"

set xlabel 'f_{cw}+f_{ccw} [rev/sec]'
set ylabel "{/Symbol D}s' [mm]"

titulek1 = sprintf("Fit: f(x) = 8{/Symbol p}AD^2x/((%.2f\261%.2f)(D+B) 10^{11})", c*10**-3*10**-8, (c_err*10**-3)*10**-8)

set output name.".pdf"
plot name.".txt" using 1:2:3 title "Naměřená data" with yerrorbars  pt 1 lc rgb "red", f(x) title titulek1

#close()

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###