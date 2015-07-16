import numpy as np

# Kopfzeile auslesen
file = "guete_pi_mode.tsv"
with open(file, "r") as f:
    for line in f:
        el = line.split()
        if el[0] != "#": break
        
        if el[1] == "Center:": center = float(el[-1])
        if el[1] == "Span:": span = float(el[-1])
        if el[1] == "Points:": points = int(el[-1])

start = center - 0.5 * span
stop = center + 0.5 * span

# Datenpunkte einlesen
data = np.loadtxt(file)

re = np.array(data[:,0])
im = np.array(data[:,1])
mag = np.sqrt(re**2 + im**2)

v = np.linspace(start, stop, points)

np.savetxt("freq_eval.tsv", np.column_stack((v, mag)), delimiter='\t')
