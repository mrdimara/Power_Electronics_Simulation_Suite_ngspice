set encoding utf8
set termoption noenhanced
set title "*========================================================"
set xlabel "s"
set ylabel "V"
set grid
unset logscale x 
set xrange [1.000000e-08:1.000000e+00]
unset logscale y 
set yrange [-1.563170e+00:3.282657e+01]
#set xtics 1
#set x2tics 1
#set ytics 1
#set y2tics 1
set format y "%g"
set format x "%g"
plot 'mppt_filters.data' using 1:2 with lines lw 1 title "v(/pd)",\
'mppt_filters.data' using 3:4 with lines lw 1 title "v(/pb)"
