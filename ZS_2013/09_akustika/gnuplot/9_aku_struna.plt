set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside left top box
set fit errorvariables

f(x) = A*x
fit f(x) '9_aku_struna_data.txt' using 1:2 via A


set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output "9_aku_struna_out.pdf"

#set yrange [0:5]
#set xrange [-25:20]
set ylabel "f [Hz]"
set xlabel "n [-]"

# \261 je plus-minus symbol
set label "y(x) = %.2f", A, "(\261%.2f)x ", A_err at 5.5,50 

plot '9_aku_struna_data.txt' using 1:2 title "Naměřené hodnoty" lw 2 lt 1 lc rgb "red", f(x) title "Lineární proložení"

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###