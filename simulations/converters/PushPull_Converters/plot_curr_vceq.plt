set encoding utf8
set termoption noenhanced
set title "* ============================================"
set xlabel "s"
set ylabel "A"
set grid
unset logscale x 
set xrange [1.000000e-09:5.000000e-03]
unset logscale y 
set yrange [-4.097493e+01:8.603129e+02]
#set xtics 1
#set x2tics 1
#set ytics 1
#set y2tics 1
set format y "%g"
set format x "%g"
plot 'plot_curr_vceq.data' using 1:2 with lines lw 1 title "viq1#branch"
