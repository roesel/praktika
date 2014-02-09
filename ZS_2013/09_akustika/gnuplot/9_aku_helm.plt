set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside left top box
set fit errorvariables

f(x) = A*x
fit f(x) '9_aku_helm_data.txt' using 1:2:($2-$3):($2+$3) via A 

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output "9_aku_helm_out.pdf"

#set yrange [0:5]
#set xrange [-25:20]
set xlabel "1/{/Symbol \326}V [1/l]"
set ylabel "f [Hz]"

# \261 je plus-minus symbol                      
set label "y(x) = %.2f", A, "(\261%.2f)x ", A_err  at 37.5,195
plot '9_aku_helm_data.txt' using 1:2:3 with yerrorbars title "Naměřené hodnoty" lw 2 lt 1 lc rgb "red", f(x) title "Lineární proložení"

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###