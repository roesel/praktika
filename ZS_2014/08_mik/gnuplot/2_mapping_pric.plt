set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside left top #box
set fit errorvariables

name = '2_mapping_pric'

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output name.'.pdf'

pi = 3.14

amplitude       = 85.4274   #       +/- 1.713        (2.006%)
sigma           = 4.10902   #       +/- 0.08969      (2.183%)
position        = 0.2      #   +/- 0.6167       (0.7226%)
delta           = 0.2

gauss(x) = amplitude/(sigma*sqrt(2.*pi))*exp(-(x-position)**2/(2.*sigma**2))+delta

fit gauss(x) name.'.txt' using 1:3 via amplitude, sigma, position, delta

amplitude1       = 45.4274   #       +/- 1.713        (2.006%)
sigma1           = 2.10902   #       +/- 0.08969      (2.183%)
position1        = 0.2      #   +/- 0.6167       (0.7226%)
delta1           = 0.2

gauss1(x) = amplitude1/(sigma1*sqrt(2.*pi))*exp(-(x-position1)**2/(2.*sigma1**2))+delta1

fit gauss1(x) name.'.txt' using 1:5 via amplitude1, sigma1, position1, delta1

#set yrange [5:75]
#set xrange [0:0.8]
set xlabel "x [cm]"
set ylabel "U [V]"

set samples 1000
set size ratio 0.5

# \261 je plus-minus symbol
#set label "y(x) = %.1f", A, "(\261%.1f)x ", A_err, "+ %.1f", B, "(\261%.1f) ", B_err at 1.1, 28 

plot name.'.txt' using 1:3 title "z = 100 mm" lw 2 lt 1 lc rgb "red" ,\
	 gauss(x) title "Fit pro z = 100 mm" lt 1 lc rgb "red" ,\
	 name.'.txt' using 1:5 title "z = 200 mm" lw 2 lt 1 lc rgb "blue" ,\
	 gauss1(x) title "Fit pro z = 200 mm" lt 1 lc rgb "blue" 

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###