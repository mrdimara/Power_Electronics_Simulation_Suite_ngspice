set encoding utf8
set termoption noenhanced
set title "*forward conv - lossless simulation"
set xlabel "s"
set grid
unset logscale x 
set xrange [1.000000e-09:1.000000e-02]
unset logscale y 
set yrange [-6.892634e-01:1.447453e+01]
#set xtics 1
#set x2tics 1
#set ytics 1
#set y2tics 1
set format y "%g"
set format x "%g"
plot 'fwd_lossless.data' using 1:2 with lines lw 2 title "i(l1)",\
'fwd_lossless.data' using 3:4 with lines lw 2 title "v(/o,/r)",\
'fwd_lossless.data' using 5:6 with lines lw 2 title "i(vis1)"
