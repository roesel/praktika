set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside left top box
set fit errorvariables

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output "8_sonar_if_1_out.pdf"

set yrange [0:5]
set xrange [-25:20]
set xlabel "{/Symbol a} [°]"
set ylabel "A [V]"

# \261 je plus-minus symbol
#set label "y(x) = %.1f", A, "(\261%.1f)x ", A_err, "+ %.1f", B, "(\261%.1f) ", B_err at 1.1, 28 

plot '8_sonar_if_data_1.txt' using 1:2 title "Měření pro N=1" lw 2 lt 1 lc rgb "red"

set output "8_sonar_if_2_out.pdf"
set yrange [0:8]
set xrange [-20:20]

plot '8_sonar_if_data_2.txt' using 1:2 title "Měření pro N=2" lw 2 lt 1 lc rgb "red"

set output "8_sonar_if_3_out.pdf"
set yrange [0:10]
set xrange [-15:20]

plot '8_sonar_if_data_3.txt' using 1:2 title "Měření pro N=5" lw 2 lt 1 lc rgb "red"


######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###