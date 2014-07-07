reset
set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
#set grid x y
set key on inside right top #box
set key samplen 2 spacing .8 font "calibri,11"

set fit errorvariables

cal(x)= a*x
a = 0.657693

files = 'Cs Co Ba Am BaCoCs BaCoCsPb CoCs unknown background'
labels = 'Cs Co Ba Am BaCoCs BaCoCsPb CoCs unknown background'

set term pdfcairo font 'calibri,14' enhanced monochrome dashed size 6,4

do for [i=1:words(files)] {
	name = word(files, i)
	set output name.".pdf"

	titulek1=name 

	#set xlabel 'E [keV]'
	#set ylabel '{/Symbol D} E [keV]'

	set xlabel 'E [keV]'
	set ylabel 'N [-]'

	#set size ratio 0.5
	#set samples 1000

	#set yrange [0:]
	#set xrange [0:]
	
	set style fill solid 1.0

	plot name.".txt" using (cal($1)):($2-$3) with boxes title titulek1 lw 1 lt 1 lc rgb "blue"
	#plot name.".txt" using (cal($1)):($2) with boxes title titulek1 lw 1 lt 1 lc rgb "blue"
}
######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###