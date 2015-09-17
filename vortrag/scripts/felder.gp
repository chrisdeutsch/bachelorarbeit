### PLOTTEMPLATE
reset

# \textwidth = 15.86cm
set term epslatex color size 12cm,8cm

set key top right
set key samplen 2

set decimalsign '{,}'
set format x "%.0f"
set format y "%.0f"

#set xtics 210,300,2010
set ytics 0,2000,8000


set xrange [0:2220]
set yrange [-500:8000]
set xlabel '$z$ / \si{mm}'
set ylabel '$\frac{E_0(z)}{\sqrt{P_\mathrm{V}}}$ / \si{\volt\per\metre\per\watt\tothe{0{,}5}}'

set samples 10000
set grid
set bars small

load './scripts/gnuplot_linestyles.gp'

### HEADER ENDE

#################
### PETRA-III ###
#################

### PI ###
set output './plots/messung_pi_1.tex'

plot '../mythesis/data/PETRA-III/fundamental/pi/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4

set output './plots/messung_pi_2.tex'

plot '../mythesis/data/PETRA-III/fundamental/pi/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
'../mythesis/data/PETRA-III/fundamental/pi/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4


### FOOTER START
unset output
### FOOTER ENDE
