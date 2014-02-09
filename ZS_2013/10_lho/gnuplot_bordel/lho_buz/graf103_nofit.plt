set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right top box
set fit errorvariables

name = '20g_1.txt'

f(x)=a*(1/sqrt(((o**2-x**2)**2)+(4*l*(x**2))))
a=1
o=1.1
l=0.3
#fit f(x) 'data103.txt' using 1:2 via a,o,l
titulek1="data"
titulek2="fit" #: f(x)=(0,96±0,09)/sqrt(((3,37±0,01)^2-x^2)^2+4·(0,05±0,01)·x^2)"
set xlabel "f [Hz]"
set ylabel "x [mm]"
#plot [3.2:3.7] [0.4:0.75] 'data103.txt' with points title titulek1, f(x) title titulek2
#set label "f(x) = (%.2f", a, "\261%.2f) ", a_err, "*(1/sqrt((((%.2f", o, "\261%.2f) ", o_err, "**2-x**2)**2)+(4*(%.2f", l, "\261%.2f) ", l_err, "*(x**2))))" at graph 0.02, graph 0.05
plot name with points title titulek1#, f(x) title titulek2
# (%.2f", a, "\261%.2f) ", a_err, "
set terminal png
set output 'out.png'
replot