set encoding utf8
set termoption noenhanced
set title "*========================================================"
set xlabel "s"
set ylabel "V"
set grid
unset logscale x 
set xrange [1.000000e-08:1.000000e+00]
unset logscale y 
set yrange [-5.000000e-02:1.050000e+00]
#set xtics 1
#set x2tics 1
#set ytics 1
#set y2tics 1
set format y "%g"
set format x "%g"
plot 'pwm_gate.data' using 1:2 with lines lw 1 title "v(/g)"
