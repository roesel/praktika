set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
#set grid x y
set key on inside right top #box
set fit errorvariables

name = '3_stoj'

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output name.'.pdf'

lambda          = 0.40898  #        +/- 0.005966     (0.5913%)
fi              = -1.40177 #        +/- 0.6374       (45.47%)
delta           = 1.80333  #        +/- 0.2495       (11.86%)
amplitude = 1.7

f(x) = amplitude*cos(lambda*x+fi)+delta

fit f(x) name.'.txt' using 1:2 via lambda, fi#, delta#, amplitude

set yrange [0:5]
#set xrange [0:0.8]
set xlabel "x' [mm]"
set ylabel "U [V]"

set samples 1000
set size ratio 0.5

pi=3.14159
titulek = sprintf("f(x) = %.1f cos( (%.3f\261%.3f) x + (%.1f\261%.1f) ) + %.1f      {/Symbol l} = (%.1f\261%.1f) mm", amplitude, lambda, lambda_err, fi, fi_err, delta, (2*2*pi/lambda), (2*2*pi*lambda_err/lambda**2))
plot name.'.txt' using 1:2 title "Naměřené hodnoty" lw 2 lt 1 lc rgb "red", f(x) title titulek lt 1 lc rgb "red"


######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###