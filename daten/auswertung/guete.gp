reset
set term unknown
set macros
set dummy v
set samples 10000
set fit errorvariables

filename="guete_031.tsv"
span=100000.0
center=499500000.0
points=2001

start=center-span/2.0
step=span/(points-1)


#Bestimmung des minimalen y-Wertes
plot filename u (start + $0 * step):(sqrt($1**2 + $2**2))

y_min=GPVAL_DATA_Y_MIN


#Bestimmung des x-Wertes des Minimums
plot filename u ((sqrt($1**2 + $2**2)) == y_min ? (sqrt($1**2 + $2**2)) : 1/0):0
x_min = GPVAL_DATA_Y_MIN


#Umrechnung in Frequenz
#Startwerte setzen
v0 = (start + x_min * step)
k=1
Q0=1
n=0
v0_temp=0
Q0_temp=0
k_temp=0
fitspan=50000#span

rho(x)=(10**(x/10.))
RL(x)=10*log10(x)
fehler(x,y) = (RL(y)>(-10)&&RL(y)<(3)) ? (rho(RL(y)+0.4+0.04*x/(10**9))) : ( (RL(y)>(-20)&&RL(y)<(-10)) ? (rho(RL(y)+1)) : ( (RL(y)>(-30)&&RL(y)<(-20)) ? (rho(RL(y)+3)) : (rho(50)) ) ) 


#Fitfunktion
f(v) = sqrt( ((k - 1)**2 + Q0**2 * (v / v0 - v0 / v)**2) / ((k + 1)**2 + Q0**2 * (v / v0 - v0 /v)**2 ) )


#Iteratives fitten

#Abbruchkriterium ist jetzt sehr klein und ich finde doof gewählt
abbr=(10**(-12))

while (abs(Q0_temp-Q0)>abbr || abs(k_temp-k)>abbr || abs(v0_temp-v0)>abbr){

	k_temp=k
	Q0_temp=Q0
	v0_temp=v0

	fit [v0-fitspan/2.0:v0+fitspan/2.0] f(v) filename using (start + $0 * step):(sqrt(($1)**2 + ($2)**2)): ( fehler( (start + $0 * step) , (sqrt(($1)**2 + ($2)**2)) ) ) zerror via k
	fit [v0-fitspan/2.0:v0+fitspan/2.0] f(v) filename using (start + $0 * step):(sqrt(($1)**2 + ($2)**2)): ( fehler( (start + $0 * step) , (sqrt(($1)**2 + ($2)**2)) ) ) zerror via Q0
	fit [v0-fitspan/2.0:v0+fitspan/2.0] f(v) filename using (start + $0 * step):(sqrt(($1)**2 + ($2)**2)): ( fehler( (start + $0 * step) , (sqrt(($1)**2 + ($2)**2)) ) ) zerror via v0
	n=n+1
	print sprintf("Iterationsschritt %i",n)
	
}

#Fitparameter zusammenpacken
fit [v0-fitspan/2.0:v0+fitspan/2.0] f(v) filename using (start + $0 * step):(sqrt(($1)**2 + ($2)**2)): (fehler( (start + $0 * step) , (sqrt(($1)**2 + ($2)**2)) )) zerror via k, Q0, v0
n=n+1


# Plot
set term epslatex color size 20cm,15cm standalone header \
"\\usepackage{siunitx}\
\\sisetup{\
  output-decimal-marker={,},\
  separate-uncertainty\
}"

set output 'guete.tex'

set decimalsign '{,}'

set xrange [v0-0.5*fitspan:v0+0.5*fitspan]
set yrange [*:*]
set xlabel '$\nu$ / \si{MHz}'
set ylabel '$\rho$'

set key bottom right
set grid

plot filename using ((start + $0 * step)):(sqrt($1**2 + $2**2)) t'Resonanzkurve', f(v) t'Fit'
