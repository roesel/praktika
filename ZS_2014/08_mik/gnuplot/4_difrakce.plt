set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right top #box
set fit errorvariables

name = '4_difrakce'

pi = 3.14

amplitude       = 6.6671       #   +/- 0.7269       (2.726%)
sigma           = 9.6208       #   +/- 0.6195       (3.157%)
position        = 140       #   +/- 0.6167       (0.7226%)
delta           = 0

gauss(x) = amplitude/(sigma*sqrt(2.*pi))*exp(-(x-position)**2/(2.*sigma**2))+delta

fit [130:145] gauss(x) name.'.txt' using 1:3 via amplitude, sigma, position

amplitude1      = 30.8913      #    +/- 0.8524       (2.759%)
sigma1          = 10.2793      #    +/- 0.3278       (3.189%)
position1       = 88.8144      #    +/- 0.3275       (0.3687%)
delta1           = 0

gauss1(x) = amplitude1/(sigma1*sqrt(2.*pi))*exp(-(x-position1)**2/(2.*sigma1**2))+delta1

fit [55:120] gauss1(x) name.'.txt' using 1:3 via amplitude1, sigma1, position1

DegToRad(x) = x*(3.14159/180)
k = 2*3.14159/32.22
Io = 1.34
Ioo = 0.58
D=60
E=40
f(x) = Io*(((sin(0.5*k*D*sin(DegToRad(90-x))))/(0.5*k*D*sin(DegToRad(90-x))))**2)
h(x) = Ioo*(((sin(0.5*k*E*sin(DegToRad(90-x))))/(0.5*k*E*sin(DegToRad(90-x))))**2)
g(x) = 0.5*Io*(1+cos(k*D*sin(DegToRad(90-x))))

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output name.'.pdf'

#set yrange [5:75]
#set xrange [0:0.8]
set xlabel "{/Symbol q} [°]"
set ylabel "U [V]"

set samples 1000
set size ratio 0.5

l_d = 2*D/3*sin((position-position1)/180*pi)
d_position = position-position1
d_position_err = sqrt(position_err**2+position1_err**2)#2/3*D*cos(pi/180*(position-position1))*pi/180*
l_d_err = l_d*d_position_err/d_position

# \261 je plus-minus symbol
#set label "y(x) = %.1f", A, "(\261%.1f)x ", A_err, "+ %.1f", B, "(\261%.1f) ", B_err at 1.1, 28 

plot name.'.txt' using 1:2 title "Data pro D=40 mm" lw 2 lt 1 lc rgb "red",\
     name.'.txt' using 1:3 title sprintf("Data pro D=60 mm    {/Symbol l} = (%.1f\261%.1f) mm", l_d, l_d_err) lw 2 lt 1 lc rgb "blue",\
	 h(x) lc rgb "#000000" title 'Předpokládaná závislost pro D=40 mm' with lines,\
	 f(x) lc rgb "#000000" title 'Předpokládaná závislost pro D=60 mm' with lines
	 #gauss(x) title sprintf("Fit pro d=60: {/Symbol q}= (%.1f\261%.1f)", position, position_err) lt 1 lc rgb "red",\
	 #gauss1(x) title sprintf("Fit pro d=60: {/Symbol q}= (%.1f\261%.1f)", position1, position1_err) lt 1 lc rgb "blue",\
	 #f(x) lc rgb "#000000" title '' with lines


######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###