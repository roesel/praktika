# GNU PLOT SCRIPT
reset

set encoding utf8
#set decimalsign ','
#set decimalsign locale "czech"

# skript papa data ve tvaru:
#   t[ms]      Uloop[V]      Iplasma[A]    overT[eV]
# words(retezec) - vrací kolik je v retezci slov
# word(retezec, i) - vraci slovo v retezci na i-te pozici

shots = "14681 14683 14685 14709 14710 14711 14712"
mins  = "0.0225 0.02475 0.02445 0.0225 0.0225 0.0225 0.0225"
maxs  = "0.0230 0.02525 0.02495 0.0230 0.0230 0.0230 0.0230"

do for [i=1:words(shots)] {
	shot_number = word(shots, i)
	min = word(mins, i)
	max = word(maxs, i)
	name = 'T_merge_'.shot_number

	set grid x y
	set xlabel "t [s]"
	set ylabel "\over T [eV]"
	tit1 = '\over T pro #'.shot_number

	set terminal pdfcairo enhanced font ',12'
	set output name.'.pdf'
	set key inside top right box

	plot [min:max] name.'.txt' using 1:4 title tit1 with lines
}

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot sin(x)
######### WORKFIX DUMP ###