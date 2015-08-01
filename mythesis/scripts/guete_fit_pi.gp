### PLOTTEMPLATE
reset

# \textwidth = 15.86cm
set term epslatex color size 12cm,8cm

set output './plots/guete_fit_pi.tex'

set key bottom right

set decimalsign '{,}'
set format x "%.2f"
set format y "%.1f"

#set xtics 499.46,0.02,499.54
set ytics 0.0,0.2,1.0

set xrange [(499506965.541+30000-30000)/1.0e6:(499506965.541+30000+30000)/1.0e6]
set yrange [0:1.0]
set xlabel '$\nu$ / \si{MHz}'
set ylabel '$|\rho|$'

set samples 10000
set grid
#set bars small

load './scripts/gnuplot_linestyles.gp'

### HEADER ENDE
filename = "./data/guete_fit_pi.tsv"

# Fitergebnisse (Scipy):
kappa = 1.01284891868      # +- 0.000905857262026
Q0 = 29560.1891285         # +- 13.4223845832
v0 = 499506965.541/1.0e6 + 0.03 # +- 1.02283884466


# Fithypothese
set dummy v
rho(v) = sqrt( ((kappa-1)**2 + Q0**2 *(v/v0 - v0/v)**2) / ((kappa+1)**2 + Q0**2 * (v/v0 - v0/v)**2) )

plot filename u ($1/1.0e6 + 0.03):2:(0.01*$2) every 10 w yerror ls 1 t'Messpunkte', rho(v) ls 2 t'Anpassung'

### FOOTER START
unset output
### FOOTER ENDE
