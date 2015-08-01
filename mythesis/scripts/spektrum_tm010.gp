### PLOTTEMPLATE
reset

# \textwidth = 15.86cm
set term epslatex color size 12cm,8cm

set output './plots/spektrum_tm010.tex'

set key bottom right

set decimalsign '{,}'
set format x "%.0f"
set format y "%.1f"

#set xtics 499.46,0.02,499.54
set ytics 0.0,0.2,1.0

set xrange [496000000.0 / 1.0e6 : 512000000.0 / 1.0e6]
set yrange [0:1.1]
set xlabel '$\nu$ / \si{MHz}'
set ylabel '$|\rho|$'

set samples 10000
set grid
#set bars small

load './scripts/gnuplot_linestyles.gp'

### HEADER ENDE
filename = "./data/spektrum_tm010.tsv"

plot filename u ($1/1.0e6):2 smooth unique ls 1 t'Spektrum'

### FOOTER START
unset output
### FOOTER ENDE
