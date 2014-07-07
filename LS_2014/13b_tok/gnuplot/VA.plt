# GNU PLOT SCRIPT / uloha 13b U_float
reset

set encoding utf8
set fit errorvariables
set decimalsign ','
#set decimalsign locale "czech"

data_output = 'VA__output'

set print data_output.'.txt'
print "#VA data from fits"
set print data_output.'_fits.txt'
print "#VA data from fits"

shots = "14681 14683 14685 14709 14710 14711 14712"
mins  = "0.02250 0.02475 0.02445 0.02250 0.02250 0.02250 0.02250"
maxs  = "0.02300 0.02525 0.02495 0.02300 0.02300 0.02300 0.02300"
#mins  = "0.02250 0.02475 0.02445 0.02265 0.02265 0.02265 0.02265"
#maxs  = "0.02300 0.02525 0.02495 0.02305 0.02305 0.02305 0.02305"

set format y "%1.2f"

do for [i=1:words(shots)] {

	shot_number = word(shots, i)
	min = word(mins, i)*10**6
	max = word(maxs, i)*10**6
	name = 'VA_merge_'.shot_number

	f(x) = A*(1-exp((x-B)/C))
	A               = 0.0110551    
	B               = -53.2062     
	C               = 16           
	
	# every ::(min)::(min+(max-min)/3)  
	fit [-100:-30] f(x) name.'.txt' using ($2*100):($3/22) every ::(min)::(max) via A,B,C
	
	set grid x y
	set size ratio 0.5
	set xlabel "U [V]"
	set ylabel "I [A]"
	tit1 = 'VA char. pro #'.shot_number.'      '.sprintf("t = %s až %s s", word(mins, i), word(maxs, i))

	set terminal pdfcairo enhanced font ',12'
	set output name.'.pdf'
	
	set key inside bottom left box
	
	if (shot_number=="14710")  {
		tit = sprintf("f(x)=A(1-exp((x-B)/C)                         C = (%.0f\261%.0f)", C, C_err) 
	}
	else {
		tit = sprintf("f(x)=A(1-exp((x-B)/C)                    C = (%.1f\261%.1f)", C, C_err) \
	}
	
	set print data_output.'.txt' append
	print sprintf("Fit T for shot #%s on %s - %s is $(%.1f \\pm %.1f)$", shot_number, word(mins, i), word(maxs, i), C, C_err)
	
	set print data_output.'_fits.txt' append
	print sprintf("f(x) =	(%.4f \\pm %.4f) \\left(1-\\mathrm{exp}\\left(\\frac{x-(%.1f\\pm %.1f)}{(%.1f\\pm %.1f)}\\right)\\right)", A, A_err, B, B_err, C, C_err)
	
	plot name.'.txt' every ::(min)::(max) using ($2*100):($3/22) title tit1 with lines, f(x) title tit
}

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot sin(x)
######### WORKFIX DUMP ###