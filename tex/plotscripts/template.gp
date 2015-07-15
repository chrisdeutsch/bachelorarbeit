reset

set term epslatex color size 5,3.5

set output './plots/outfile.tex'

set key top right

set decimalsign '{,}'
set format x "%.1f"

set xrange [*:*]
set yrange [*:*]
set xlabel 'xlabel $x$ / \si{m}'
set ylabel 'ylabel $y$ / \si{s}'

set grid
set bars small

load './plotscripts/gnuplot_linestyles.gp'


pi = 3.14
plot sin(x) ls 1 t'', sin(x + pi/5) ls 2 t'', sin(x + 2*pi/5) ls 3 t'', sin(x + 3*pi/5) ls 4 t'', sin(x + 4*pi/5) ls 5 t'', sin(x + 5*pi/5) ls 6 t'', sin(x + 3*pi/5) ls 4 t''
unset output
