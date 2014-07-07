set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
#set grid x y
set key on inside right top #box
set key samplen 2 spacing .8 font "calibri,11"

set fit errorvariables

name = 'BaCoCsandPb'

set term pdfcairo font 'calibri,14' enhanced monochrome dashed size 6,4
set output name."2.pdf"

cal(x)= c*x
c = 0.657693

d = 1.5e-3
mi(x,y) = -(1/d)*log(x/y)

titulek1 = "spektrum ^{137}Cs, ^{60}Co a ^{133}Ba bez stínění" 
titulek2 = "spektrum ^{137}Cs, ^{60}Co a ^{133}Ba se stíněním" 

set xlabel 'E [keV]'
set ylabel 'N [-]'

#titulek2 = sprintf("{/Symbol m}(E) = 1/( (%.5f\261%.5f) E )", a, a_err) 

set size ratio 0.5
set samples 1000

#set yrange [0:1800]
set xrange [0:2500]

set style fill solid 0.5

plot name.".txt" using (cal($1)):($2) with boxes title titulek1 lw 1 lt 1 lc rgb "#78AFFF",\
     name.".txt" using (cal($1)):($3) with boxes title titulek2 lw 1 lt 1 lc rgb "#0066FF"

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###