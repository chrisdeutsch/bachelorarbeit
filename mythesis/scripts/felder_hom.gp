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

### 702 MHz ###
set output './plots/HOM/702MHz.tex'

plot './data/HOM/702/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     #'./data/HOM/702/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4

### 712 MHz ###
set output './plots/HOM/712MHz.tex'

plot './data/HOM/712/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     #'./data/HOM/712/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4
     
### 730 MHz ###
set output './plots/HOM/730MHz.tex'

plot './data/HOM/730/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     #'./data/HOM/730/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4
     
### 1047 MHz ###
set output './plots/HOM/1047MHz.tex'

plot './data/HOM/1047/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     #'./data/HOM/1047/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4
     
### 1375 MHz ###
set output './plots/HOM/1375MHz.tex'

plot './data/HOM/1375/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     #'./data/HOM/1375/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4

### 1458 MHz ###
set output './plots/HOM/1458MHz.tex'

plot './data/HOM/1458/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     #'./data/HOM/1458/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4

### 1460 MHz ###
set output './plots/HOM/1460MHz.tex'

plot './data/HOM/1460/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     #'./data/HOM/1460/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4

### 1465_L MHz ###
set output './plots/HOM/1465_L_MHz.tex'

plot './data/HOM/1465_L/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     #'./data/HOM/1465_L/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4
     
### 1465_M MHz ###
set output './plots/HOM/1465_M_MHz.tex'

plot './data/HOM/1465_M/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     #'./data/HOM/1465_M/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4
     
### 1465_R MHz ###
set output './plots/HOM/1465_R_MHz.tex'

plot './data/HOM/1465_R/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     #'./data/HOM/1465_R/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4

### 1545 MHz ###
set output './plots/HOM/1545MHz.tex'

plot './data/HOM/1545/feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" ls 1 pt 7 ps 0.4,\
     #'./data/HOM/1545/eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" ls 2 pt 7 ps 0.4

### FOOTER START
unset output
### FOOTER ENDE
