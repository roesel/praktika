reset

set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside bottom right #box
set fit errorvariables

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4

name='hyst'

set samples 1000
set size ratio 0.5
set ytics 1
#set format x "%.2f"
#set format y "%.1f"

set xlabel 'H [A/m]'
set ylabel 'B [T]'

set output name.".pdf"
plot name.".txt" using 1:2 title "A->D" with points pt 1 lc rgb "red",\
	 name.".txt" using 3:4 title "D->A" with points pt 1 lc rgb "blue"

close()