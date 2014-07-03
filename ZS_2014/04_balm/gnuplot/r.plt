reset

set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside top right #box
set fit errorvariables

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4

name='r'

f(x) = (4*x*x/(x*x-4))/R
R=0.01
fit f(x) name.".txt" using 1:2 via R # nebo 1:2 (??)

set samples 1000
set size ratio 0.5
set xrange [2.5:5.5]
set format x "%.1f"
#set format y "%.1f"

set xlabel 'n [-]'
set ylabel '{/Symbol l} [nm]'

titulek = sprintf("Fit: f(x) = [4x^2/(x^2-4)]/R    R=(%.4f\261%.4f)", R, R_err)

set output name.".pdf"
plot name.".txt" using 1:2 title "Naměřená data H" with points pt 1 lc rgb "red", f(x) title titulek

close()