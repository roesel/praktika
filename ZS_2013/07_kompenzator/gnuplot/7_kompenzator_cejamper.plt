set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside left top box
set fit errorvariables

f(x) = A*x + B
fit f(x) '7_kompenzator_cejamper_data.txt' using 1:2 via A,B

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output "7_kompenzator_cejamper_out.pdf"

set xrange [0:0.8]
set yrange [0:0.8]
set xlabel "Ia[mA]"
set ylabel "Ik[mA]"

# \261 je plus-minus symbol
set label "y(x) = %.2f", A, "(\261%.2f)x ", A_err, "+ %.3f", B, "(\261%.3f) ", B_err at 0.35,0.65 

plot '7_kompenzator_cejamper_data.txt' using 1:2 title "Naměřená data" lw 2 lt 1 lc rgb "red", f(x) title "Kalibrační křivka" lt 2

#### Kalibrační křivka ####

set output "7_kompenzator_cejamper_kalib_out.pdf"

set yrange [-0.035:0.035]
set xlabel "Ia[mA]"
set ylabel "{/Symbol D}I [mA]"

set style arrow 1 nohead ls 2
set arrow from 0.240, -0.018 to 0.400, -0.021 as 1
plot '7_kompenzator_cejamper_data.txt' using 1:3 title "Naměřená data" with lines lw 2, '7_kompenzator_cejamper_data.txt' every ::3::3 using 1:3 title "Chyba"  



######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###