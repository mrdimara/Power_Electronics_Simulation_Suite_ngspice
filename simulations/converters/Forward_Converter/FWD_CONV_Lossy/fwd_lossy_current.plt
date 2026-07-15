set encoding utf8
set termoption noenhanced
set title "*forward conv - lossy simulation"
set xlabel "s"
set ylabel "A"
set grid
unset logscale x 
set xrange [1.000000e-09:1.000000e-02]
unset logscale y 
set yrange [-2.134830e-05:4.243728e-04]
#set xtics 1
#set x2tics 1
#set ytics 1
#set y2tics 1
set format y "%g"
set format x "%g"
plot 'fwd_lossy_current.data' using 1:2 with lines lw 2 title "i(vid1)"
