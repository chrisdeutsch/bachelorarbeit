### PLOTTEMPLATE
reset

# \textwidth = 15.86cm
set term epslatex color size 15cm,10cm

set key top right
set key samplen 2

set decimalsign '{,}'
set format x "%.0f"
set format y "%.0f"

#set xtics 210,300,2010
#set ytics start,step,stop


set xrange [0:2220]
set yrange [*:*]
set xlabel '$z$ / \si{mm}'
set ylabel '$\frac{E_0(z)}{\sqrt{P_\mathrm{V}}}$ / \si{\volt\per\metre\per\watt\tothe{0.5}}'

set samples 10000
set grid
set bars small

load './scripts/gnuplot_linestyles.gp'

### HEADER ENDE

#################
### PETRA-III ###
#################

### PI ###
set output './plots/PETRA-III/pi.tex'

plot './data/PETRA-III/fundamental/pi/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     './data/PETRA-III/fundamental/pi/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4

### 2/3 PI ###
set output './plots/PETRA-III/2_3_pi.tex'
set key bottom right

plot './data/PETRA-III/fundamental/2_3_pi/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     './data/PETRA-III/fundamental/2_3_pi/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4

set key top right

### 1/3 PI ###
set output './plots/PETRA-III/1_3_pi.tex'

plot './data/PETRA-III/fundamental/1_3_pi/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     './data/PETRA-III/fundamental/1_3_pi/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4

### 0 PI ###
set output './plots/PETRA-III/0_pi.tex'

plot './data/PETRA-III/fundamental/0_pi/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     './data/PETRA-III/fundamental/0_pi/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4


#################
### PETRA-IV ###
#################

### PI ###
set output './plots/PETRA-IV/pi.tex'

plot './data/PETRA-IV/fundamental/pi/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     './data/PETRA-IV/fundamental/pi/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4

### 2/3 PI ###
set output './plots/PETRA-IV/2_3_pi.tex'
set key bottom right

plot './data/PETRA-IV/fundamental/2_3_pi/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     './data/PETRA-IV/fundamental/2_3_pi/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4

set key top right

### 1/3 PI ###
set output './plots/PETRA-IV/1_3_pi.tex'

plot './data/PETRA-IV/fundamental/1_3_pi/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     './data/PETRA-IV/fundamental/1_3_pi/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4

### 0 PI ###
set output './plots/PETRA-IV/0_pi.tex'

plot './data/PETRA-IV/fundamental/0_pi/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     './data/PETRA-IV/fundamental/0_pi/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4




### FOOTER START
unset output
### FOOTER ENDE
