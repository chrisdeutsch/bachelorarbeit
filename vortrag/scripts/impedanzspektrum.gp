### PLOTTEMPLATE
reset

# \textwidth = 15.86cm
set term epslatex color size 12cm,8cm

set key top right
set key samplen 2

set decimalsign '{,}'
#set format x "%.0f"
#set format y "%.0f"

#set xtics 210,300,2010
#set ytics 0,2000,8000

set logscale y
set ytics ('\SI{1}{\kilo\ohm}' 1e3, '\SI{10}{\kilo\ohm}' 1e4, '\SI{100}{\kilo\ohm}' 1e5, '\SI{1}{\mega\ohm}' 1e6, '\SI{10}{\mega\ohm}' 1e7, '\SI{100}{\mega\ohm}' 1e8)
set xtics 500,200,1500

set xrange [450:1500]
set yrange [1e3:1e8]
set xlabel '$\nu$ / \si{MHz}'
set ylabel '$R_\mathrm{S}$'

set samples 10000
set grid
set bars small

load './scripts/gnuplot_linestyles.gp'

### HEADER ENDE

#################
### PETRA-III ###
#################

### PI ###
set output './plots/impedanzspektrum.tex'

# LABELS
set label '\scriptsize{$\mathrm{TM}_{010}$}' at 505, 38E6 center front
set label '\scriptsize{$\mathrm{TE}_{111}$}' at 702, 500E3 center front
set label '\scriptsize{$\mathrm{TM}_{011}$}' at 730, 70E3 center front
set label '\scriptsize{$\mathrm{TM}_{111}$}' at 1047, 3.6E3 center front
#set label '\scriptsize{$\mathrm{TM}$}' at 1375, 5.2E3 center front
set label '\scriptsize{$\mathrm{TM}_{021}$}' at 1450, 280E3 center front


plot './data/petra3.tsv' using 1:2:3 w yerrorbars t'PETRA-III' ls 1 pt 7 ps 0.6,\
     './data/petra4.tsv' using 1:2:3 w yerrorbars t'PETRA-IV' ls 2 pt 7 ps 0.6

### FOOTER START
unset output
### FOOTER ENDE
