reset
set term postscript enhanced color eps 20 solid
set output "pollutions-set.eps"

set xlabel "# pollutions / op" font ",19"
set ylabel "Throughput (Mops)" font ",19"

set xrange [0:40]
set yrange [0:900]
set ytics 200
set key right top font ",19"
set datafile separator ","
unset key

#set size ratio 0.3
#set size 1, 0.7

set loadpath '../plot-common'
load 'xyborder.cfg'

plot "pollutions.csv" using 1:6 title "Folklore" \
		with lp ls 1 lw 5, \
	'' using 1:4 title "DRAMHiT" \
		with lp ls 2 lw 5, \
	'' using 1:2 title "DRAMHiT-P" \
		with lp ls 3 lw 5
