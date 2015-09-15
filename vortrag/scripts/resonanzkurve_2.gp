### PLOTTEMPLATE
reset

# \textwidth = 15.86cm
set term epslatex color size 8cm,5cm

set output './plots/resonanzkurve_2.tex'

set key bottom right
set key samplen 2

set decimalsign '{,}'
set format x "%.2f"
set format y "%.1f"

set xtics 0.99,0.01,1.01
set ytics 0.0,0.2,1.0

set xrange [0.99:1.01]
set yrange [0:1.0]
set xlabel '$\frac{\omega}{\omega_0}$'
set ylabel '$|\rho|$'

set samples 10000
unset grid
#set bars small

load './scripts/gnuplot_linestyles.gp'

### HEADER ENDE
kappa = 1.1
Q0 = 300

kappa2 = 1.0
Q02 = 250

kappa3 = 0.5
Q03 = 500

kappa4 = 2.0
Q04 = 500

# Fithypothese
rho(x) = sqrt( ((kappa-1)**2 + Q0**2 *(x - 1.0/x)**2) / ((kappa+1)**2 + Q0**2 * (x - 1.0/x)**2) )
rho2(x) = sqrt( ((kappa2-1)**2 + Q02**2 *(x - 1.0/x)**2) / ((kappa2+1)**2 + Q02**2 * (x - 1.0/x)**2) )
rho3(x) = sqrt( ((kappa3-1)**2 + Q03**2 *(x - 1.0/x)**2) / ((kappa3+1)**2 + Q03**2 * (x - 1.0/x)**2) )
rho4(x) = sqrt( ((kappa4-1)**2 + Q04**2 *(x - 1.0/x)**2) / ((kappa4+1)**2 + Q04**2 * (x - 1.0/x)**2) )

plot rho(x) ls 1 t''

### FOOTER START
unset output
### FOOTER ENDE
