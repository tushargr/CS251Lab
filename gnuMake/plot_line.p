set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
#set terminal postscript eps enhanced color
set key samplen 2 spacing 1.5 font ",22"
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set xlabel "Time (No.of elements)"
set ylabel "Time(microseconds)"
set yrange[0:]
set xrange[0:2000000]
set ytic auto
set xtic auto
set output "single_1.eps"
plot 'single_1.out' using 1:2 title "Thread1" with linespoints, \
	 'single_2.out' using 1:2 title "Thread2" with linespoints, \
	'single_4.out' using 1:2 title "Thread4" with linespoints, \
	'single_8.out' using 1:2 title "Thread8" with linespoints, \
	 'single_16.out' using 1:2 title "Thread16" with linespoints, \
