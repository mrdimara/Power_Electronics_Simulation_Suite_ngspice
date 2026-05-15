set encoding utf8
set termoption noenhanced
set title "*========================================================"
set xlabel "s"
set ylabel "V"
set grid
unset logscale x 
set xrange [1.000000e-08:1.000000e-04]
unset logscale y 
set yrange [-5.482155e-18:2.841683e-19]
#set xtics 1
#set x2tics 1
#set ytics 1
#set y2tics 1
set format y "%g"
set format x "%g"
plot 'output_voltage_after.data' using 1:2 with lines lw 1 title "v(/o)"
