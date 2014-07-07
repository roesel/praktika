set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right top #box
set key samplen 2 spacing .8 font "calibri,11"

set fit errorvariables

name='BaCoCsandPb'

set term pdfcairo font 'calibri,14' enhanced monochrome dashed size 6,4
set output name.".pdf"

cal(x)= c*x
c = 0.657693

d = 1.5e-3
mi(x,y) = -(1/d)*log(x/y)

titulek1="Naměřené hodnoty všech zářičů" 

f(x)= 1/(a*x) #\pm 0.003421
a = 6.86431e-005  #   +/- 5.084e-006   (7.407%)
fit [5:75] f(x) name.".txt" using 1:(abs(mi($3, $2))) via a

set xlabel 'E [keV]'
set ylabel '{/Symbol m} [-]'

titulek2 = sprintf("{/Symbol m}(E) = 1/ (a*E), a =(%.5f\261%.5f) ", a, a_err) 

set size ratio 0.5
set samples 1000

set yrange [0:1800]
set xrange [0:300]

plot [0:300] name.".txt" using (cal($1)):(mi($3, $2)) title titulek1 lw 1 lt 1 lc rgb "red", f(x) lt 1 title titulek2

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###