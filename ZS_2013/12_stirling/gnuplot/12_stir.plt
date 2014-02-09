set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right bottom #box
set fit errorvariables

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output "12_stir.pdf"

f(x)= A*x**2 + B*x + C
fit f(x) '12_stir_data.txt' using 1:2 via A,B,C

titulek1 = "Naměřené hodnoty"
titulek2 = sprintf("g(N) = (%.4f\261%.4f) N^2 + (%.1f\261%.1f) N +  (%.0f\261%.0f)", A, A_err, B, B_err, C, C_err)

set xlabel "N [rpm]"
set ylabel "P_e [mW]"

#set yrange [-0.05:0.01]
set xrange [300:900]

plot "12_stir_data.txt" using 1:2 title titulek1 lw 2 lt 1 lc rgb "red", f(x) lw 2 lt 2 title titulek2#, g(x) lt 1  title sprintf("{/Symbol w}_0")

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###
