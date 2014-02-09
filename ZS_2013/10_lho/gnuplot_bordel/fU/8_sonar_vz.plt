set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside left top box
set fit errorvariables

f(x) = A*x + B
fit f(x) 'data.txt' using 1:2 via A,B

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output "data.pdf"

#set yrange [5:75]
#set xrange [0.34:2.145]
set xlabel "t [ms]"
set ylabel "s [cm]"

# \261 je plus-minus symbol
#set label "y(x) = %.1f", A, "(\261%.1f)x ", A_err, "+ %.1f", B, "(\261%.1f) ", B_err at 1.1, 28
set label "y(x) = %.3f", A, "(\261%.3f)x ", A_err, "+ %.2f", B, "(\261%.2f) ", B_err at graph 0.1, graph 0.1 

plot 'data.txt' using 1:2 title "Naměřená data" lw 2 lt 1 lc rgb "red", f(x) title "Fit" lt 2

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###