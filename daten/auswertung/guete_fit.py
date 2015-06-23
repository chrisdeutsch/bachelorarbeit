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
    
    # Fitrange
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

if __name__ == '__main__':
    infile = sys.argv[1]
    
    popt, perr = fit(infile)
    
    print("v0 = {} +- {}".format(popt[0], np.sqrt(perr[0])))
    print("Q0 = {} +- {}".format(popt[1], np.sqrt(perr[1])))
    print("k = {} +- {}".format(popt[2], np.sqrt(perr[2])))

#import glob
#if __name__ == '__main__':
#    refs = list(glob.iglob('*_ref.tsv'))
#    refs.sort()
#    
#    pts = list(glob.iglob('*mm.tsv'))
#    pts.sort()
#    
#    with open('evaluated.tsv', 'w') as f:
#        f.write("# Pos v0 d Q0 d k d v0r d Q0r d kr d\n")
#        for ref, pt in zip(refs, pts):
#            print(pt)
#            pos = int(ref[0:4])
#            assert(pos == int(pt[0:4]))
#            
#            ref_opt, ref_err = fit(ref)
#            opt, err = fit(pt)
#            
#            outlist = [pos, opt[0], err[0], opt[1], err[1], opt[2], err[2], ref_opt[0], ref_err[0], ref_opt[1], ref_err[1], ref_opt[2], ref_err[2]]
#            
#            f.write('\t'.join(map(str,outlist)) + '\n')
