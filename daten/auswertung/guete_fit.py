import sys
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit, minimize_scalar, bisect
from scipy.interpolate import interp1d

def fit(file):
    # Kopfzeile auslesen
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
    
    try:
        v_lo = bisect(f, v[0], v0)
        v_hi = bisect(f, v0, v[points-1])
    except ValueError:
        v_lo = v[0]
        v_hi = v[points-1]
            
    dv = v_hi - v_lo
    Q0 = (1 + kappa) * v0 / dv
    
    # Fitrange Automatisieren!
    fitrange = (v_lo < v) & (v < v_hi)
    
    # Fit der Resonanzkurve
    def rho(v, v0, Q0, kappa):
        return np.sqrt( ((kappa - 1)**2 + Q0**2 * (v/v0 - v0/v)**2) / ((kappa + 1)**2 + Q0**2 * (v/v0 - v0/v)**2))
        
    popt, pcov = curve_fit(rho, v[fitrange], mag[fitrange], p0 = [v0, Q0, kappa])
    perr = np.sqrt(np.diag(pcov))
    
    mag_fit = rho(v, *popt)
    plt.plot(v, mag, 'r-', linewidth=1.0, label="data")
    plt.plot(v[fitrange], mag_fit[fitrange], 'b-', linewidth=1.0, label="fit")
    plt.legend()
    plt.show()
    
    return (popt, perr)


#if __name__ == '__main__':
#    infile = sys.argv[1]
#    
#    popt, perr = fit(infile)
#    
#    print("v0 = {} +- {}".format(popt[0], np.sqrt(perr[0])))
#    print("Q0 = {} +- {}".format(popt[1], np.sqrt(perr[1])))
#    print("k = {} +- {}".format(popt[2], np.sqrt(perr[2])))

import glob
if __name__ == '__main__':
    measurements = list(glob.iglob('*.tsv'))
    measurements.sort()
    
    with open('evaluated.tsv', 'w') as f:
        f.write("#v0\tdv0\tQ0\tdQ0\tk\tdk\n")
        for m in measurements:
            opt, err = fit(m)
            
            outlist = [opt[0], err[0], opt[1], err[1], opt[2], err[2]]
            f.write('\t'.join(map(str, outlist)) + '\n')
            
