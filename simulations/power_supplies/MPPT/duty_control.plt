set encoding utf8
set termoption noenhanced
set title "*========================================================"
set xlabel "s"
set ylabel "V"
set grid
unset logscale x 
set xrange [0.000000e+00:1.000000e-01]
unset logscale y 
set yrange [-8.635286e-02:1.108684e-02]
#set xtics 1
#set x2tics 1
#set ytics 1
#set y2tics 1
set format y "%g"
set format x "%g"
plot 'duty_control.data' using 1:2 with lines lw 1 title "v(/d)"
