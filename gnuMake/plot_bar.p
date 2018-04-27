
set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set output "bar.eps"

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
plot 'bar.out' u 2:xticlabels(1) title "Thread1",\
'' u 3 title "Thread2" fillstyle pattern 7,\
'' u 4 title "Thread3" fillstyle pattern 12,\
'' u 5 title "Thread4" fillstyle pattern 14,\
'' u 6 title "Thread5" fillstyle pattern 15

