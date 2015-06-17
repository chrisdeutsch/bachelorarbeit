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

set xrange [0:*]
set yrange [0:*]
set xlabel '$d$ / \si{mm}'
set ylabel '$E$ / \si{\volt\per\metre}'

set grid

#set label 1 "$U_\\mathrm{max} = \\SI{434.4+-0.5}{V}$" at 1900, 320
#set label 2 "$R_\\mathrm{S} = \\SI{23.7+-1.1}{\\mega\\ohm}$" at 1900, 280

set bars small

plot 'eval.tsv' using 1:3:2:4 w xyerrorbars t"Messpunkte" pt 7 ps 0.4

unset output
