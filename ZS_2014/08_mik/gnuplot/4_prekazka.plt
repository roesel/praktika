set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right top #box
set fit errorvariables

name = '4_prekazka'

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output name.'.pdf'

#set yrange [5:75]
#set xrange [0:0.8]
set xlabel "x [mm]"
set ylabel "U [V]"

set samples 1000
set size ratio 0.5

# \261 je plus-minus symbol
#set label "y(x) = %.1f", A, "(\261%.1f)x ", A_err, "+ %.1f", B, "(\261%.1f) ", B_err at 1.1, 28 

plot name.'.txt' using 1:2 title "Naměřené hodnoty" lw 2 lt 1 lc rgb "red"#, gauss(x) title "Fit pro d=40" lt 1 lc rgb "red"

#set output name2.'.pdf'

#plot name2.'.txt' using 1:2 title "Naměřené hodnoty" lw 2 lt 1 lc rgb "red"

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###