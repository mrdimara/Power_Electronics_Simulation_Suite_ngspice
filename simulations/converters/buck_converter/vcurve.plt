set encoding utf8
set termoption noenhanced
set title "*buck simulation"
set xlabel "s"
set ylabel "A"
set grid
unset logscale x 
set xrange [1.000000e-08:1.000000e-01]
unset logscale y 
set yrange [-8.956759e-01:1.724203e-01]
#set xtics 1
#set x2tics 1
#set ytics 1
#set y2tics 1
set format y "%g"
set format x "%g"
plot 'vcurve.data' using 1:2 with lines lw 2 title "v(v1#branch)"
