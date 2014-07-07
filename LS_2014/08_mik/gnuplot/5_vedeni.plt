set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right top #box
set fit errorvariables

name = '5_vedeni'

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output name.'.pdf'


lambda          = 3.93824       #   +/- 0.05796      (1.472%)
fi              = 1.8294        #   +/- 0.5565       (30.42%)
delta           = 0.170474      #   +/- 0.006563     (3.85%)
amplitude = 0.08

f(x) = amplitude*cos(lambda*x+fi)+delta

fit f(x) name.'.txt' using 1:2 via lambda, fi, delta#, amplitude


#set yrange [5:75]
#set xrange [0:0.8]
set xlabel "x [cm]"
set ylabel "U [V]"

set size ratio 0.5
set samples 1000

# \261 je plus-minus symbol
#set label "y(x) = %.1f", A, "(\261%.1f)x ", A_err, "+ %.1f", B, "(\261%.1f) ", B_err at 1.1, 28 

titulek = sprintf("f(x) = %.1f cos( (%.2f\261%.2f) x + (%.1f\261%.1f) ) + %.1f      {/Symbol l} = (%.1f\261%.1f) mm", amplitude, lambda, lambda_err, fi, fi_err, delta, (10*2*2*pi/lambda), (10*2*2*pi*lambda_err/lambda**2))

plot name.'.txt' using 1:2 title "Naměřené hodnoty" lw 2 lt 1 lc rgb "red", f(x) title titulek lt 1 lc rgb "red"

#set output name2.'.pdf'

#plot name2.'.txt' using 1:2 title "Naměřené hodnoty" lw 2 lt 1 lc rgb "red"

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###