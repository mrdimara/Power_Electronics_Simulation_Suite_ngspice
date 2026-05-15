set encoding utf8
set termoption noenhanced
set title "*========================================================"
set xlabel "s"
set ylabel "V"
set grid
unset logscale x 
set xrange [1.000000e-08:1.280039e-04]
unset logscale y 
set yrange [-6.021632e-03:1.261642e-01]
#set xtics 1
#set x2tics 1
#set ytics 1
#set y2tics 1
set format y "%g"
set format x "%g"
plot 'control_signal.data' using 1:2 with lines lw 1 title "v(/d)"
