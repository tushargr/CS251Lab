set terminal postscript eps enhanced color size 3.9,2.9


set key font ",12"
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set xlabel "No.of elements"
set ylabel "Thread speedup"
set yrange[0:]
set ytic auto
set boxwidth 1 relative
set style data histograms
set style histogram cluster
set style fill pattern border

set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set output "ebar.eps"
set xtics rotate by -45
set style histogram errorbars lw 3
set style data histogram

plot 'ebar.out' u 2:7:xticlabels(1) title "Thread1",\
'' u 3:8 title "Thread2" fillstyle pattern 7,\
'' u 4:9 title "Thread4" fillstyle pattern 12,\
'' u 5:10 title "Thread8" fillstyle pattern 14,\
'' u 6:11 title "Thread16" fillstyle pattern 15
