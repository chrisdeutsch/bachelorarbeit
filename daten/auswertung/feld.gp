reset

set term epslatex color size 20cm,15cm standalone header \
"\\usepackage{siunitx}\
\\sisetup{\
  output-decimal-marker={,},\
  separate-uncertainty\
}"

set output 'neu.tex'

#set format y '%.1f'

set key top right

set decimalsign '{,}'

set xrange [0:2220]
set yrange [*:*]
set xlabel '$d$ / \si{mm}'
set ylabel '$E/\sqrt{P}$ / \si{\volt\per\metre\per\watt\tothe{0.5}}'

set grid

set bars small

plot 'feld.tsv' using 1:3:2:4 w xyerrorbars t"Amplitude" pt 7 ps 0.4,\
     'eff_feld.tsv' using 1:3:2:4 w xyerrorbars t"effektives Feld" pt 7 ps 0.4

unset output
