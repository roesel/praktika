reset

set encoding utf8
set decimalsign ','
#set decimalsign locale "czech"
set grid x y
set key inside bottom right box
#set key samplen 2 spacing .8 font "calibri,11"

set fit errorvariables

set format y "%1.1f"
set format x "%1.1f"

name='r_data'

set terminal pdfcairo enhanced font ',12'
set output name.".pdf"

titulek1="r(h)" 

a = 8.5 # cm!!

f(x)= A*x+B 
fit f(x) name.".txt" using ($2/10):(a*sqrt(1-($5/(2*$3)))):(sqrt( a**2/(16*$3**2)/(1-0.5*($5/$3))  *  $6**2 + a**2*$5**2/(16*$3**4)/(1-0.5*($5/$3))  *  $4**2 )) via A, B

set xlabel "h [cm]"
set ylabel "r [cm]"

titulek2 = sprintf("f(x) = (%.1f\261%.1f) x + (%.0f\261%.0f) ", A, A_err, B, B_err) 

set size ratio 0.5
#set samples 1000

#set yrange [0:]
set xrange [7:8.4]

plot name.".txt" using ($2/10):(a*sqrt(1-($5/(2*$3)))):(sqrt( a**2/(16*$3**2)/(1-0.5*($5/$3))  *  $6**2 + a**2*$5**2/(16*$3**4)/(1-0.5*($5/$3))  *  $4**2 )) with yerrorbars title titulek1 lw 1 lt 1 lc rgb "red", f(x) title titulek2

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###