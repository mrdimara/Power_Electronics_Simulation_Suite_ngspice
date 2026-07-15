set encoding utf8
set termoption noenhanced
set title "*boost converetr simulation"
set xlabel "s"
set ylabel "A"
set grid
unset logscale x 
set xrange [0.000000e+00:1.000000e-01]
unset logscale y 
set yrange [-5.469905e+02:1.147152e+04]
#set xtics 1
#set x2tics 1
#set ytics 1
#set y2tics 1
set format y "%g"
set format x "%g"
plot 'i_l.data' using 1:2 with lines lw 1 title "i(l1)"
