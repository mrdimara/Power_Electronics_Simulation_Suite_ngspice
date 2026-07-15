set encoding utf8
set termoption noenhanced
set title "*simulation for flyback converter"
set xlabel "s"
set ylabel "A"
set grid
unset logscale x 
set xrange [1.000000e-09:5.000000e-03]
unset logscale y 
set yrange [-2.372967e-02:4.983225e-01]
#set xtics 1
#set x2tics 1
#set ytics 1
#set y2tics 1
set format y "%g"
set format x "%g"
plot 'plot2.data' using 1:2 with lines lw 1 title "i(vip1)",\
'plot2.data' using 3:4 with lines lw 1 title "i(vis1)"
