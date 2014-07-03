reset
set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside top right #box
set fit errorvariables

name = '2_malus'

pi = 3.14159265359
#mal(x) = (403-364)*sin((x-90)/360*2*pi)**4+364

mal(x) = (403-364)*cos(x/360*2*pi)**2 + 364

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output name.'.pdf'

set xlabel "{/Symbol q} [°]"
set ylabel "U [V]"

set samples 1000
set size ratio 0.5

plot name.'.txt' using 1:2 title "Naměřené hodnoty" lw 2 lt 1 lc rgb "red", mal(x) title "Malusův zákon" lt 1 lc rgb "red"

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###