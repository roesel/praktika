set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside right top box
set fit errorvariables

f(x)=a*exp(-1*l*x)*cos(o*x+h)
a=0.0762384
l=0.0489291
o=3.53963
h=-15.8896
titulek1="data"
titulek2="fit" #: f(x)=(0.359±0.009)·exp(-(0.372±0.004)x)·cos((3.550±0.004)x+(6.93±0.02))"

set xlabel "t [s]"
set ylabel "x [m]"
#set label "f(x) = (%.3f", a, "\261%.3f) ", a_err, "exp(-(%.3f", l, "\261%.3f)x) ", l_err, "cos((%.3f", o, "\261%.3f)x ", o_err, "+ (%.3f", h, "\261%.3f)) ", h_err at graph 0.02, graph 0.05
#plot [4.4:15.0] [-0.06:0.06] 'data109.txt' with points title titulek1, f(x) title titulek2
plot '03_10g.txt' with points title titulek1#, f(x) title titulek2
set terminal png
set output 'graf109.png'
replot