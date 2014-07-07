reset
set encoding utf8
set terminal pdfcairo enhanced dashed size 7,5
unset key
set xlabel "x [-]"
set ylabel "z [-]"
set zlabel "U [V]"
#set xtics 1
#set ytics 1
set contour
set dgrid3d
set pm3d

do for [i=1:3] {

name="konfigurace_".i."_out"

set output name.".pdf"
splot name.".txt" using 1:2:3

}
#nize plot mapy
reset

set terminal pdfcairo enhanced dashed size 7,7

do for [i=1:3] {

name="konfigurace_".i."_out"

unset key
set xlabel "z [-]"
set ylabel "x [-]"
set zlabel "U [V]" #treti osa, nejspis zbytecna... ale nicemu nevadi
#set xtics 1
#set ytics 1
set contour
set dgrid3d
#set pm3d .... pravdepodobne zybtecne nastavuju dvakrat, ale fungovalo to
set pm3d map
set yrange [0:11.01]
set xrange [0:11.01]

set output name."_mapa.pdf"
splot name.".txt" using 1:2:3

}
######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###