### PLOTTEMPLATE
reset

# \textwidth = 15.86cm
set term epslatex color size 12cm,8cm

set output './plots/outfile.tex'

set key top right

set decimalsign '{,}'
set format x "%.1f"
set format y "%.1f"

#set xtics start,step,stop
#set ytics start,step,stop


set xrange [*:*]
set yrange [*:*]
set xlabel 'xlabel $x$ / \si{m}'
set ylabel 'ylabel $y$ / \si{s}'

set samples 10000
set grid
set bars small

load './scripts/gnuplot_linestyles.gp'

### HEADER ENDE

pi = 3.14
plot sin(x) ls 1 t'', sin(x + pi/5) ls 2 t'', sin(x + 2*pi/5) ls 3 t'', sin(x + 3*pi/5) ls 4 t'', sin(x + 4*pi/5) ls 5 t'', sin(x + 5*pi/5) ls 6 t'', sin(x + 3*pi/5) ls 4 t''

### FOOTER START
unset output
### FOOTER ENDE
