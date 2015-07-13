import numpy as np
from uncertainties import ufloat
import uncertainties.unumpy as unumpy
import uncertainties.umath as umath
from scipy.integrate import trapz

# Berechnung der Störkörperkonstante
radius = ufloat(0.01, 0.0001)
epsilon = ufloat(2.1, 0.01)
epsilon0 = 8.854187817E-12

alpha_s = 4.0 / 3.0 * np.pi * radius**3 * epsilon0 * 3*(epsilon - 1.0)/(epsilon + 2.0)

# Güte und Resonanzfrequenz
Q0 = ufloat(29000, 200)
v0 = ufloat(499.67E+6, 0.01E+6)

# Daten einlesen
data = np.loadtxt("pi_messung_1.tsv")

# Position extrahieren
pos_err = 2
pos = np.array([ufloat(x, pos_err) for x in data[:, 0]])

# Frequenzverschiebung
dv_err = 100
dv = -np.array([ufloat(x, dv_err) for x in data[:, 3]])

# Feldberechnung
field_norm_sq = 2 * Q0 * dv / (np.pi * alpha_s * v0**2) # SAUERLAND FRAGEN! FAKTOR 2

for i in range(len(field_norm_sq)):
    if field_norm_sq[i].n < 0:
        field_norm_sq[i] = ufloat(0.0, field_norm_sq[i].s)

field_norm = unumpy.sqrt(field_norm_sq)

for i in range(len(field_norm)):
    if umath.isnan(field_norm[i].s):
        field_norm[i] = ufloat(field_norm[i].n, np.sqrt(field_norm_sq[i].s))


# Ergebnisse speichern (Alternative: unumpy.nominal_values(arr) / unumpy.std_devs(arr))
pos_out = np.array([[x.nominal_value, x.std_dev] for x in pos])
field_out = np.array([[x.nominal_value, x.std_dev] for x in field_norm])

out = np.column_stack((pos_out, field_out))

np.savetxt('eval.tsv', out, delimiter='\t')

x = [val.n / 1000 for val in pos]
y = [val.n for val in field_norm]
dy = [val.s for val in field_norm]

voltage = trapz(y, x)

offset = np.array([p.nominal_value - 35 for p in pos])/1000.0

y2 = np.array([val.n for val in field_norm]) * np.abs(np.sin(2*np.pi*v0.n*offset/3.0E8))
runtime = (trapz(y2,x) / voltage)**2

rs = 0.5 * voltage**2
print("Rs = " + str(rs))
print("lambda = " + str(runtime))
print("lambda*Rs = " + str(runtime*rs))
