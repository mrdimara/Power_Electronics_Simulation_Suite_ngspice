set encoding utf8
set termoption noenhanced
set title "% full wave - bridge rectifier"
set xlabel "s"
set ylabel "A"
set grid
unset logscale x 
set xrange [1.000000e-08:1.000000e-02]
unset logscale y 
set yrange [-5.699448e+00:5.720084e+00]
#set xtics 1
#set x2tics 1
#set ytics 1
#set y2tics 1
set format y "%g"
set format x "%g"
plot 'i_l_v_id_ip.data' using 1:2 with lines lw 1 title "i(l1)",\
'i_l_v_id_ip.data' using 3:4 with lines lw 1 title "i(vid1)",\
'i_l_v_id_ip.data' using 5:6 with lines lw 1 title "i(vip1)"
