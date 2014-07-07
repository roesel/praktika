reset

set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside top right #box
set fit errorvariables

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4

name='hg'

f(x) = n_n+C/(x-l_n)
fit f(x) name.".txt" using 1:2 via n_n, C, l_n

set samples 1000
set size ratio 0.5
#set format x "%.2f"
set format y "%.3f"

set xlabel '{/Symbol l} [nm]'
set ylabel 'n [-]'

titulek = sprintf("Fit: f(x) = (%.3f\261%.3f) + (%.0f\261%.0f)/(x - (%.0f\261%.0f) )", n_n, n_n_err, C, C_err, l_n-3, l_n_err-1)

set output name.".pdf"
plot name.".txt" using 1:2 title "Naměřená data Hg" with points pt 1 lc rgb "red", f(x) title titulek

close()