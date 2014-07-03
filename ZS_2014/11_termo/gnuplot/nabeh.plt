reset

set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
#set grid x y
set key on inside right bottom vertical maxrows 2 #box
set fit errorvariables

round(x, d) = sprintf( d <= 0 ? '%.'.abs(d).'f' : '%d' , (sprintf('%.0f', (x / 10**d)) * 10**d))

name = 'nabeh'

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output name.'.pdf'

e = 1.602e-19
k = 1.38e-23

p(x) = a1*x + b1
q(x) = a2*x + b2

fit p(x) name.".txt" using ($1):(log($2*10e-6)) via a1, b1
fit q(x) name.".txt" using ($3):(log($4*10e-6)) via a2, b2

#set yrange [5:75]
set xrange [-8.5:-3]
set xlabel "U_a [V]"
set ylabel "ln(I_a) [-]"

set samples 1000
set size ratio 0.5

T_p = e/(k*a1)
T_q = e/(k*a2)
T_p_err = e/(k*a1*a1)*a1_err
T_q_err = e/(k*a2*a2)*a2_err

tit_Tp = sprintf("T_p = (%.0f\261%.0f) K", int(T_p*10**-2)*10**2, int(T_p_err*10**-2)*10**2)
tit_Tq = sprintf("T_q = (%.0f\261%.0f) K", int(T_q*10**-2)*10**2, int(T_q_err*10**-2)*10**2)   
tit_p = sprintf("p(x) = (%.1f\261%.1f) + (%.2f\261%.2f)x", b1, b1_err, a1, a1_err) 
tit_q = sprintf("q(x) = (%.1f\261%.1f) + (%.2f\261%.2f)x", b2, b2_err, a2, a2_err)
 
plot name.'.txt' using ($1):(log($2*10e-6)) title tit_Tp."      hodnoty 1" pt 5 ps 1 lc rgb "red",\
     name.'.txt' using ($3):(log($4*10e-6)) title tit_Tq."      hodnoty 2" pt 6 ps 1 lc rgb "blue",\
	 p(x) title tit_p lt 3 lc rgb "red",\
	 q(x) title tit_q lt 4 lc rgb "blue"

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###