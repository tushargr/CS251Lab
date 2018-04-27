all:report.pdf

report report.pdf:report.tex scatter_1.eps scatter_2.eps scatter_4.eps scatter_8.eps scatter_16.eps single_1.eps single_2.eps single_4.eps single_8.eps single_16.eps bar.eps ebar.eps
	pdflatex report.tex
plot:plot_scatter.p plot_line.p plot_bar.p plot_ebar.p scatter_1.out scatter_2.out scatter_4.out scatter_8.out scatter_16.out single_1.out single_2.out single_4.out single_8.out single_16.out bar.out ebar.out
	gnuplot plot_scatter.p
	gnuplot plot_line.p
	gnuplot plot_bar.p
	gnuplot plot_ebar.p
plot_scatter.p scatter_1.eps scatter_2.eps scatter_4.eps scatter_8.eps scatter_16.eps:scatter_1.out scatter_2.out scatter_4.out scatter_8.out scatter_16.out
	gnuplot plot_scatter.p
plot_line.p single_1.eps single_2.eps single_4.eps single_8.eps single_16.eps:single_1.out single_2.out single_4.out single_8.out single_16.out
	gnuplot plot_line.p
plot_bar.p bar.eps:bar.out
	gnuplot plot_bar.p
plot_ebar.p ebar.eps:ebar.out
	gnuplot plot_ebar.p

analyse scatter_1.out scatter_2.out scatter_4.out scatter_8.out scatter_16.out single_1.out single_2.out single_4.out single_8.out single_16.out bar.out ebar.out:log.out analyse_scatter.sh analyse_line.sh analyse_bar.sh analyse_ebar.sh
	./analyse_scatter.sh
	./analyse_line.sh
	./analyse_bar.sh
	./analyse_ebar.sh

runtest log.out:app params.txt runtest.sh
	./runtest.sh
app:prog.o thread_function.o common.h
	gcc -o app thread_function.o prog.o -lm -lpthread
prog.o:prog.c common.h
	gcc -c prog.c -o prog.o
thread_function.o:thread_function.c common.h
	gcc -c thread_function.c -o thread_function.o
clean:
	rm -f *.o app *.out *.eps *.pdf report.log report.lof report.dvi report.aux 
