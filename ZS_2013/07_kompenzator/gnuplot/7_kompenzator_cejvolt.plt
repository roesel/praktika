set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside left top box
set fit errorvariables

f(x) = A*x + B
fit f(x) '7_kompenzator_cejvolt_data.txt' using 1:2 via A,B

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output "7_kompenzator_cejvolt_out.pdf"

set xrange [0:11]
set xlabel "Uv[V]"
set ylabel "Uk[V]"

# \261 je plus-minus symbol
set label "y(x) = %.3f", A, "(\261%.3f)x ", A_err, "+ %.2f", B, "(\261%.2f) ", B_err at 5,9.5

plot '7_kompenzator_cejvolt_data.txt' using 1:2 title "Naměřená data" lw 2 lt 1 lc rgb "red", f(x) title "Kalibrační křivka" lt 2

#### Kalibrační křivka ####

set output "7_kompenzator_cejvolt_kalib_out.pdf"

set yrange [-0.35:0.35]
set xlabel "Uv[V]"
set ylabel "{/Symbol D}U [V]"

plot '7_kompenzator_cejvolt_data.txt' using 1:3 title "Naměřená data" with lines lw 2

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###