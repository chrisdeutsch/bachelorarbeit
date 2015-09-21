### PLOTTEMPLATE
reset

# \textwidth = 15.86cm
set term epslatex color size 12cm,8cm

unset key

set decimalsign '{,}'
set format x "%.0f"
set format y "%.0f"

#set xtics 210,300,2010
set ytics -20,4,0


set xrange [0:2220]
set yrange [-20:1]
set xlabel '$z$ / \si{mm}'
set ylabel '$\Delta \nu$ / \si{\kilo\hertz}'

set samples 10000
set grid
set bars small

load './scripts/gnuplot_linestyles.gp'

### HEADER ENDE

#################
### PETRA-III ###
#################

### PI ###
set output './plots/frequenzverschiebung.tex'

plot '../daten/stoerkoerpermessung/moden/pi/pi_messung_1.tsv' using ($1+30.):($4/1000.):(0.1) w yerrorbars t"" ls 1 pt 7 ps 0.4


### FOOTER START
unset output
### FOOTER ENDE
