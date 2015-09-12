### PLOTTEMPLATE
reset

# \textwidth = 15.86cm
set term epslatex color size 6cm,3.75cm

set key bottom right
set key samplen 2

set decimalsign '{,}'
set format x "%.2f"
set format y "%.1f"

#set xtics 0.99,0.01,1.01
set ytics 0.0,0.5,1.0
unset xtics
unset ytics


set xrange [499.61:499.71]
set yrange [0:1.0]
set xlabel '$\omega$'
set ylabel '$|\rho|$'

set samples 10000
unset grid
unset key

set style line 1 lt 1 dt 1 lc rgb '#E41A1C'  # red
set style line 2 lt 1 dt 2 lc rgb '#E41A1C'  # red dashed
set style line 3 lt 1 dt 1 lc rgb '#377EB8'  # blue

set style arrow 1 heads filled size screen 0.03, 15

### HEADER ENDE
kappa = 1.037
omega0 = 499.675
omega1 = 499.645
Q0 = 30000

rho0(x) = sqrt( ((kappa-1)**2 + Q0**2 * (x/omega0 - omega0/x)**2) / ((kappa+1)**2 + Q0**2 * (x/omega0 - omega0/x)**2) )

rho1(x) = sqrt( ((kappa-1)**2 + Q0**2 * (x/omega1 - omega1/x)**2) / ((kappa+1)**2 + Q0**2 * (x/omega1 - omega1/x)**2) )


set output './plots/resonanzkurve_ref.tex'

plot rho0(x) ls 1 t''

set output './plots/resonanzkurve.tex'

# Arrow
set arrow from 499.645, 0.2 to 499.675, 0.2 as 1 front
set label '$\Delta \omega$' at 499.660, 0.27 center front

plot rho0(x) ls 2 t'', rho1(x) ls 1 t''




### FOOTER START
unset output
### FOOTER ENDE
