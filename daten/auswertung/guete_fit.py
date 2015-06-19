import sys
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit, minimize_scalar, bisect
from scipy.interpolate import interp1d


infile = sys.argv[1]

# Kopfzeile auslesen
with open(infile, "r") as f:
    for line in f:
        el = line.split()
        if el[0] != "#": break
        
        if el[1] == "Center:": center = float(el[-1])
        if el[1] == "Span:": span = float(el[-1])
        if el[1] == "Points:": points = int(el[-1])

start = center - 0.5 * span
stop = center + 0.5 * span

# Datenpunkte einlesen
data = np.loadtxt(infile)

re = np.array(data[:,0])
im = np.array(data[:,1])
mag = np.sqrt(re**2 + im**2)

v = np.linspace(start, stop, points)

# Startwerte raten
# Interpolation der Messpunkte und suche des Minimums
interpolation = interp1d(v, mag)
minimize_res = minimize_scalar(interpolation, bounds=(v[0], v[points-1]), method='bounded')

# Schätzwert Frequenz
v0 = minimize_res.x

# Schätzwert Kappa
rho_0 = float(interpolation(v0))
kappa = (1 + rho_0) / (1 - rho_0)

# Schätzwert Güte
fwhm_thr = np.sqrt(kappa**2 + 1) / (kappa + 1)

f = lambda v: float(interpolation(v)) - fwhm_thr

v_lo = bisect(f, v[0], v0)
v_hi = bisect(f, v0, v[points-1])
dv = v_hi - v_lo

Q0 = (1 + kappa) * v0 / dv


# Fit der Resonanzkurve
def rho(v, Q0, kappa, v0):
    return np.sqrt( ((kappa - 1)**2 + Q0**2 * (v/v0 - v0/v)**2) / ((kappa + 1)**2 + Q0**2 * (v/v0 - v0/v)**2))

# Fitrange
fitrange = (v_lo < v) & (v < v_hi)

popt, pcov = curve_fit(rho, v[fitrange], mag[fitrange], p0 = [Q0, kappa, v0])

print("infile: {}".format(sys.argv[1]))
print("Q0 = {}".format(popt[0]))
print("k = {}".format(popt[1]))
print("v0 = {}".format(popt[2]))

#mag_fit = rho(v, *popt)

#plt.plot(v, mag, 'r-', linewidth=1.0)
#plt.plot(v[fitrange], mag_fit[fitrange], 'b-', linewidth=1.0)

#plt.show()
