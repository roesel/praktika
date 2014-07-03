set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside top right #box
set fit errorvariables

name = '1_mallus_hori'
name2 = '1_mallus_vert'

pi = 3.14
mal_vert(x) = 5.11*sin(x/360*2*pi)**4

mal_hori(x) = 1.71*4*(sin(x/360*2*pi)*cos(x/360*2*pi))**2

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
#set terminal epslatex size 14.0cm,10.0cm color colortext
set output name.'.pdf'

set yrange [0:2.5]
#set xrange [0:0.8]
set xlabel "{/Symbol q} [°]"
set ylabel "U [V]"

set samples 1000
set size ratio 0.5

# \261 je plus-minus symbol
#set label "y(x) = %.1f", A, "(\261%.1f)x ", A_err, "+ %.1f", B, "(\261%.1f) ", B_err at 1.1, 28 

plot name.'.txt' using 1:2 title "Naměřené hodnoty" lw 2 lt 1 lc rgb "red", mal_hori(x) title "Malusův zákon" lt 1 lc rgb "red"


set yrange [0:6]
set output name2.'.pdf'

plot name2.'.txt' using 1:2 title "Naměřené hodnoty" lw 2 lt 1 lc rgb "red", mal_vert(x) title "Malusův zákon" lt 1 lc rgb "red"

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###