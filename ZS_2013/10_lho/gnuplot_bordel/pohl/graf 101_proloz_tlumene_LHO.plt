set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right top box
set fit errorvariables

name='10g_2.txt'

f(x)=a*exp(-1*l*x)*cos(o*x+h)+d       #
a=0.08
l=0.048
o=3.54
h=14.86
d=0.003
fit f(x) name using 1:2 via a,o,l,h,d
titulek1="data"
titulek2="fit" #fit: f(x)=(-370±30)·exp(-(0,53±0,01)x)·cos((16,19±0,01)x-(6,70±0,07))-(15,11±0,06)"     
set label "f(x) = (%.2f", a, "\261%.2f) ", a_err, "exp(-(%.2f", l, "\261%.2f)x) ", l_err, "cos((%.3f", o, "\261%.3f)x ", o_err, "+ (%.2f", h, "\261%.2f)) ", h_err, "+ (%.2f", d, "\261%.2f)) ", d_err   at graph 0.02, graph 0.05
set xlabel "t [s]"
set ylabel "x [mm]"
#plot [5.44:10.08] [-36:3] 'data101.txt' with points title titulek1, f(x) title titulek2
plot name with points title titulek1, f(x) title titulek2
set terminal png
set output 'out.png'
replot