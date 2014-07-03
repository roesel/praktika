# GNU PLOT SCRIPT / uloha 13b U_float
reset

set encoding utf8
#set decimalsign ','
#set decimalsign locale "czech"

shots = "14681 14683 14685 14709 14710 14711 14712"
mins  = "0.02 0.022 0.022 0.02 0.02 0.02 0.02"
maxs  = "0.03 0.032 0.032 0.03 0.03 0.03 0.03"

do for [i=1:words(shots)] {
	shot_number = word(shots, i)
	min = word(mins, i)
	max = word(maxs, i)
	name = 'rake_probe_1_'.shot_number

	set grid x y
	set xlabel "t [s]"
	set ylabel "I [A]"
	tit1 = 'I pro #'.shot_number

	set terminal pdfcairo enhanced font ',12'
	set output name.'.pdf'
	#set terminal windows enhanced monochrome font ',12'
	set key inside top right box

	plot [min:max] name.'.txt' using 1:($2/22) title tit1 with lines
}

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot sin(x)
######### WORKFIX DUMP ###