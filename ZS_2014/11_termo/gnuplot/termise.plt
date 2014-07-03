# Initial setup 
reset
set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
#set grid x y
set key on inside right top box
set fit errorvariables

# Data file name
name = 'termise'

# Output setup
set term pdfcairo font 'calibri,14' enhanced dashed size 6,4
set output name.'.pdf'

# Print do souboru (vytváření novýho datovýho souboru)
set print name.'_fits.txt'
print "# zavislost   y       x=1/T      I_0"

# Definice konstant na vypocty
e = 1.602e-19
k = 1.38e-23
S = 1.25e-5

p(x) = lnI0 + K*x

Ts = "2219.73 2079.21 1928.89 1838.46 2169.05 2044.10"
#Tzhaveni = "2380.73 2263.33 2149.10 2059.03 2309.08 2216.57"


do for [i=1:6] {
	fit p(x) name.".txt" using (sqrt(column(1))):(log(column(i+1)/1000)) via K, lnI0
	T = word(Ts, i)
	print sprintf("%.8f\t%.8f\t%.8f\t%.8f", 1/T, lnI0-2*log(T), exp(lnI0)*10**3, exp(lnI0)*lnI0_err*10**3)
}
set size ratio 0.5
set xrange[8:30]
set xlabel "{/Symbol \326}U_{KA} [{/Symbol \326}V]"
set ylabel "ln(I_a) [-]"
colors = "1 8 3 4 9 7"
plot for [i=1:6] name.'.txt' using (sqrt(column(1))):(log(column(i+1)/1000))  lc word(colors,i) title 'Měření '.i

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output name.'rich.pdf'

set yrange [-30:2]
set xrange [0:0.0006]
set xlabel "x = 1/T [1/K]"
set ylabel "y = ln(I_0) - 2ln(T) [-]"
set samples 1000
set size ratio 0.5

r(x) = a - b*x
fit r(x) name."_fits.txt" using 1:2 via a, b
tit = sprintf("p(x) = (%.1f\261%.1f) - (%.0f\261%.0f)x \n {/Symbol f} = (%.1f\261%.1f) V                             \n \
A = (%.0f\261%.0f) A m^{-2} K^{-2}", a, a_err, int(b*10**-3)*10**3, int(b_err*10**-3)*10**3, k/e*b, k/e*b_err, exp(a)/S, exp(a)*a_err/S)
	 
plot name.'_fits.txt' using 1:2 title "Spočítané hodnoty" pt 1 ps 1.5 lc rgb "red",\
	 r(x) title tit  lt 2 lc rgb "red"

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###