set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside left top box
set fit errorvariables

f(x) = A*x*x + B*x + C
fit f(x) '8_sonar_zk_data_1.txt' using 4:3 via A,B,C

g(x) = D*x*x + E*x + F
fit g(x) '8_sonar_zk_data_2.txt' using 4:3 via D,E,F

h(x) = G*x*x + H*x + I
fit h(x) '8_sonar_zk_data_3.txt' using 4:3 via G,H,I

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output "8_sonar_zk_out.pdf"

#set yrange [5:75]
#set xrange [0:0.8]
set xlabel "{/Symbol g} [°]"
set ylabel "A [V]"

# \261 je plus-minus symbol
#set label "y(x) = %.1f", A, "(\261%.1f)x ", A_err, "+ %.1f", B, "(\261%.1f) ", B_err at 1.1, 28 

plot '8_sonar_zk_data_1.txt' using 4:3 title "{/Symbol a}=45°" lw 2 lt 1 lc rgb "red", f(x) title "Fit" lt 1 lc rgb "red",\
'8_sonar_zk_data_2.txt' using 4:3 title "{/Symbol a}=60°" lw 2 lt 1 lc rgb "forest-green", g(x) title "Fit" lt 1 lc rgb "forest-green",\
'8_sonar_zk_data_3.txt' using 4:3 title "{/Symbol a}=30°" lw 2 lt 1 lc rgb "blue", h(x) title "Fit" lt 1 lc rgb "blue"


######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###