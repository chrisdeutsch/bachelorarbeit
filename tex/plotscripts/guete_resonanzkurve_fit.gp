reset

set term epslatex color size 5,3.5

set output './plots/outfile.tex'

set key bottom right

set decimalsign '{,}'
set format x "%.2f"

set xrange [(499506979.153-40000)/1.0e6:(499506979.153+40000)/1.0e6]
set yrange [*:*]
set xlabel 'Frequenz $\nu$ / \si{MHz}'
set ylabel 'Reflektionskoeffizient $|\rho|$ / \si{s}'

set samples 10000
set grid
set bars small

load './plotscripts/gnuplot_linestyles.gp'

### HEADER ENDE
filename = "./data/guete_pi_mode.tsv"

# Fitergebnisse (Scipy):
kappa = 1.01282335461
Q0 = 29559.679979
v0 = 499506979.153/1.0e6

# Fithypothese
set dummy v
rho(v) = sqrt( ((kappa-1)**2 + Q0**2 *(v/v0 - v0/v)**2) / ((kappa+1)**2 + Q0**2 * (v/v0 - v0/v)**2) )

plot filename every 8 u ($1/1.0e6):2 ls 1 t'Messpunkte', rho(v) ls 2 t'Anpassung'

### FOOTER START
unset output
### FOOTER ENDE

