# GNU PLOT SCRIPT / uloha 13b U_float
reset

set encoding utf8
set decimalsign ','
#set decimalsign locale "czech"

#set format y "%1.2f"
set format x "%1.3f"

# %s je cislo v nazvu souboru
# 		t[ms]      Uloop[V]      Iplasma[A]    overT[eV]
filename(n) = sprintf("T_merge_%s.txt", n)

name = '135_merge_T'
shots = "14681 14683 14685"
mins  = "0.0201 0.0220 0.0221 0.02 0.02 0.02 0.02"
maxs  = "0.0305 0.0314 0.0311 0.03 0.03 0.03 0.03"

set grid x y
set xlabel "t [s]"
set ylabel "@^{\257}T [eV]"
	
set terminal pdfcairo enhanced font ',12'
set output name.'.pdf'

set key inside top left box
set size ratio 0.5

tit = '@^{\257}T pro #'

plot for [i=1:words(shots)] filename(word(shots, i)) every ::word(mins,i)*10**6::word(maxs,i)*10**6 using 1:4 with lines title tit.word(shots, i)

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot sin(x)
######### WORKFIX DUMP ###