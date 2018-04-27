set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color
set key samplen 2 spacing 1 font ",22"
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set xlabel "No. of Elements"
set ylabel "in Microseconds"
set yrange[0:]
set xrange[0:2000000]
set ytic auto
set xtic auto
set output "scatter_1.eps"
plot 'scatter_1.out' using 1:2 title "Thread1" with points pt 1 ps 1.5

set output "scatter_2.eps"
plot 'scatter_2.out' using 1:2 title "Thread2" with points pt 1 ps 1.5


set output "scatter_4.eps"
plot 'scatter_4.out' using 1:2 title "Thread4" with points pt 1 ps 1.5


set output "scatter_8.eps"
plot 'scatter_8.out' using 1:2 title "Thread8" with points pt 1 ps 1.5


set output "scatter_16.eps"
plot 'scatter_16.out' using 1:2 title "Thread16" with points pt 1 ps 1.5



