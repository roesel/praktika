set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
#set grid x y
set key on inside right top #box
set key samplen 2 spacing .8 font "calibri,11"

set fit errorvariables

name='Cs'

set term pdfcairo font 'calibri,14' enhanced monochrome dashed size 6,4
set output name.".pdf"

pi = 3.14

cal(x)= a*x
a = 0.657693

unset label

# -- pik zpetneho rozptylu
position1 = 185
sigma1 = 15
amplitude1 = 10000
delta1 = 370

gauss1(x)=amplitude1/(sigma1*sqrt(2.*pi))*exp(-(x-position1)**2/(2.*sigma1**2)) + delta1
fit [150:220] gauss1(x) name.".txt" using (cal($1)):($2-$3) via amplitude1, position1, sigma1#, delta1 


set label sprintf("%.0f\261%.0f", position1, position1_err)  at first  (position1-30), first  800 font "Calibri,11"

titulek_zpet = sprintf("position1 = (%.0f\261%.0f)", position1, position1_err)

# -- rentgenovy pik
amplitude       = 24423.5  #        +/- 2158         (8.838%)
position        = 22.2226   #       +/- 0.5623       (2.53%)
sigma           = 5.55737    #      +/- 0.5768       (10.38%)9%
delta = 0

gauss(x)=amplitude/(sigma*sqrt(2.*pi))*exp(-(x-position)**2/(2.*sigma**2)) + delta
fit [10:50] gauss(x) name.".txt" using (cal($1)):($2-$3) via amplitude, position, sigma#, delta 

set label sprintf("%.1f\261%.1f", position, position_err)  at first  (position+10), first  2000 font "Calibri,11"

set label "470\2615"  at first  460, first  650 font "Calibri,11"

titulek1 = name 
 

set xlabel 'E [keV]'
set ylabel 'N [-]'

#set size ratio 0.5
#set samples 1000

set yrange [0:]
set xrange [0:1000]

set style fill solid 1.0

plot name.".txt" using (cal($1)):($2-$3) with boxes title titulek1 lw 1 lt 1 lc rgb "blue"#, gauss1(x) title titulek_zpet, gauss(x) title titulek2
#plot name.".txt" using (cal($1)):($2) with boxes title titulek1 lw 1 lt 1 lc rgb "blue"#, gauss(x) title titulek2

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###