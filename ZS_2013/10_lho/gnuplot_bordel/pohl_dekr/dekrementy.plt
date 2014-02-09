set encoding utf8
set decimalsign ','
set decimalsign locale "czech"
set grid x y
set key on inside left top #box
set fit errorvariables

set term pdfcairo font 'calibri,14' enhanced dashed monochrome size 6,4
set output "../../gnuplot/10_pohl_dekrementy.pdf"

g(x) =  3.538


f(x)=a*exp(b*x)
a=1
b=1
fit f(x) 'dekrementy.txt' every ::4 using 1:2:3 via a,b

titulek1="Naměřené hodnoty"
titulek2 = sprintf("f(I) = (%.2f\261%.2f) e^{(%.2f\261%.2f)I} ", a, a_err, b, b_err)

set xlabel "I [A]"
set ylabel "{/Symbol d} [rad/s]"

#set yrange [-0.05:0.01]
#set xrange [4.8:8]

plot [0:2.0] "dekrementy.txt" with points title titulek1 lw 2 lt 1 lc rgb "red", f(x) lw 2 lt 2 title titulek2, g(x) lt 1  title sprintf("{/Symbol w}_0")

######### WORKFIX DUMP ###
set term pdfcairo
set output '_____dump.pdf'
plot 'data.txt' using 1:2
######### WORKFIX DUMP ###
