reset
set encoding utf8
set terminal pdfcairo enhanced dashed size 7,5
unset key
set xlabel "x"
set ylabel "z"
set zlabel "U [V]"
#set xtics 1
#set ytics 1
set contour
set dgrid3d
set pm3d

name="2_mapping3d"

set output name.".pdf"
splot name.".txt" using 1:2:3


#nize plot mapy
reset
set terminal pdfcairo enhanced dashed size 7,7
unset key
set xlabel "z"
set ylabel "x"
set zlabel "U [V]" #treti osa, nejspis zbytecna... ale nicemu nevadi
#set xtics 1
#set ytics 1
set contour
set dgrid3d
#set pm3d .... pravdepodobne zybtecne nastavuju dvakrat, ale fungovalo to
set pm3d map
set yrange [-25.1:25.1]
set xrange [4.9:55.1]

set output name."_mapa.pdf"
splot name.".txt" using 1:2:3

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###