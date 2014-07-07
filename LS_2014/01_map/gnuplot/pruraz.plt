reset

set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside bottom right #box
set fit errorvariables

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4

name='pruraz'

f(x) = a*x + 1
#f(x) = -1/(a*x)+b
#f(x) = a*log(x+1)+1
fit f(x) name.".txt" using 1:2 via a

set samples 1000
set size ratio 0.5
set format x "%.2f"
set format y "%.1f"

set xlabel 's/D [-]'
set ylabel 'f(s/D) [-]'

titulek = sprintf("Fit: f(x) = (%.2f\261%.2f)x + 1 ", a, a_err)

set output name.".pdf"
plot name.".txt" using 1:2 every ::0::12 title "Naměřená data pro d = 12,05 mm" with points pt 1 lc rgb "red",\
	 name.".txt" using 1:2 every ::13::25 title "Naměřená data pro d = 13,75 mm" with points pt 2 lc rgb "blue",\
	 name.".txt" using 1:2 every ::26::38 title "Naměřená data pro d = 11,10 mm" with points pt 4 lc rgb "black",\
	 f(x) title titulek

close()