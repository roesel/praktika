set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
#set grid x y
set key on inside right top #box
set key samplen 2 spacing .8 font "calibri,11"

set fit errorvariables

name='Cs1_pb'

set term pdfcairo font 'calibri,14' enhanced monochrome dashed size 6,4
set output name.".pdf"

titulek1="Spektrum ^{137}Cs se stíněním" 

set xlabel "U_E [V]"
set ylabel "N [-]"

#set size ratio 0.5
#set samples 1000

#set yrange [-0.028:0.023]
set xrange [0:10]

set style fill solid 1.0

plot name.".txt" using 1:2 with boxes title titulek1 lw 1 lt 1 lc rgb "blue"

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###