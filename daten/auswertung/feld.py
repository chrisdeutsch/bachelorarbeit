import numpy as np
from uncertainties import ufloat
import uncertainties.unumpy as unumpy
import uncertainties.umath as umath


# Berechnung der Störkörperkonstante
radius = ufloat(0.01, 0.0001)
epsilon = ufloat(2.1, 0.01)
epsilon0 = 8.85E-12

alpha_s = 4.0 / 3.0 * np.pi * radius**3 * epsilon0 * 3*(epsilon - 1.0)/(epsilon + 2.0)


# Einkopplungsfaktor & Standing Wave Ratio
kappa = ufloat(1.012, 0.0040)
swr = kappa if kappa > 1.0 else 1.0 / kappa

# Verlustleistung des Resonators
dBm = ufloat(6.0, 0.2)  # Fehler?
power = 0.001 * 10**(dBm / 10.0)
powerloss = 4 * swr / (1 + swr)**2 * power

# Güte und Resonanzfrequenz
Q0 = ufloat(29500, 500)
v0 = ufloat(499.67E+6, 0.01E+6)

# Energie im Resonator
E = Q0 * powerloss / (2 * np.pi * v0)

# Daten einlesen
data = np.loadtxt('pi_messung_2.tsv')

# Position extrahieren
pos_err = 2
pos = np.array([ufloat(x, pos_err) for x in data[:, 0]])

# Frequenzverschiebung
dv_err = 100
dv = -np.array([ufloat(x, dv_err) for x in data[:, 3]])

# Feldberechnung (Dirty Hack?)
field_square = 2 * E / alpha_s * dv / v0

for i in range(len(field_square)):
    if field_square[i].n < 0:
        field_square[i] = ufloat(0.0, field_square[i].s)

field = unumpy.sqrt(field_square)

for i in range(len(field)):
    if umath.isnan(field[i].s):
        field[i] = ufloat(field[i].n, np.sqrt(field_square[i].s))       

# Ergebnisse speichern (Alternative: unumpy.nominal_values(arr) / unumpy.std_devs(arr))
pos_out = np.array([[x.nominal_value, x.std_dev] for x in pos])
field_out = np.array([[x.nominal_value, x.std_dev] for x in field])

out = np.column_stack((pos_out, field_out))

np.savetxt('eval.tsv', out, delimiter='\t')
