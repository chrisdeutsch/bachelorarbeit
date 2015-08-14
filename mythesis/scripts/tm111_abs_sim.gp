### PLOTTEMPLATE
reset

# \textwidth = 15.86cm
set term epslatex color size 12cm,5cm

set output './plots/tm111_abs_sim.tex'

set key top right

set decimalsign '{,}'
set format x "%.0f"
set format y "%.0f"

#set xtics 499.46,0.02,499.54
#set ytics 0.0,0.2,1.0

set xrange [0:2220]
set yrange [0:10]
set xlabel '$z$ / \si{mm}'
set ylabel '$|\vec{E}_0(z)|$ / willk.\ Einh.'

set samples 10000
unset grid
#set bars small

load './scripts/gnuplot_linestyles.gp'

### HEADER ENDE
filename = "./data/tm111_abs_sim.tsv"

plot filename u ($1/2343.6000976563*2220):($2/2500000*10) smooth unique ls 1 lw 1 t''

### FOOTER START
unset output
### FOOTER ENDE
