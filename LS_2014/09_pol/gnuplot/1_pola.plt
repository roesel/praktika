reset

set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside bottom right #box
set fit errorvariables

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4

name='1_pola'

DegToRad(x) = x*(3.14159/180)

n = 1.5
alpha = 0.6
delta = 1.3
p(x) = delta + alpha * (((cos(DegToRad(x) - asin((sin(DegToRad(x)))/(n))))**2 - (cos(DegToRad(x) + asin((sin(DegToRad(x)))/(n))))**2)/((cos(DegToRad(x) - asin((sin(DegToRad(x)))/(n))))**2 + (cos(DegToRad(x) + asin((sin(DegToRad(x)))/(n))))**2))

fit p(x) name.".txt" using 1:2 via n, alpha, delta

set pointsize 2
set samples 1000
set size ratio 0.5

set xlabel '{/Symbol q} [°]'
set ylabel '|~P{.8-}| [-]'

set xrange[35:77]

titulek = sprintf("Fit hodnot: n = (%.3f\261%.3f),    {/Symbol a} = (%.3f\261%.3f),    {/Symbol d} = (%.3f\261%.3f) ", n, n_err, alpha, alpha_err, delta, delta_err)

set output name.".pdf"
plot  name.".txt" using 1:2 title "Naměřená data" with points pt 1 lc rgb "red", p(x) lt 1 lc rgb "#000000" title titulek# with lines

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###