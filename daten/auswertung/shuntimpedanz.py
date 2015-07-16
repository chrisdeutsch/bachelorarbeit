import numpy as np
from uncertainties import ufloat
import uncertainties.unumpy as unumpy
import uncertainties.umath as umath
from trapz import trapz
from scipy.optimize import minimize_scalar


### Berechnung des elektrischen Feldes ###

# Berechnung der Störkörperkonstante
radius = ufloat(0.01, 0.0001)
epsilon = ufloat(2.1, 0.01)
epsilon0 = 8.85418781762E-12

# Einfluss des Bohrlochs?
vol_s = 4.0 / 3.0 * np.pi * radius**3
alpha_s = 3.0 * (epsilon - 1.0) / (epsilon + 2.0) * epsilon0 * vol_s

# Güte und Resonanzfrequenz
# TODO: Frequenzverschiebung aufgrund der Luft im Resonator
Q0 = ufloat(29000.0, 200.0)
v0 = ufloat(499.67E+6, 0.01E+6) # Resonanzfrequenz Vakuum->Luft?

# Daten einlesen
data = np.loadtxt("pi_messung_1.tsv")

# Position extrahieren [mm]
pos_err = 0.5
pos = np.array([ufloat(pos, pos_err) for pos in data[:, 0]])

# Frequenzverschiebung extrahieren
dv_err = 100.0
dv = np.array([ufloat(dv, dv_err) for dv in data[:, 3]])

# Elektrisches Feld ist auf !!!P_V normiert!!!
e_field_sq = -2.0 * Q0 * dv / (np.pi * alpha_s * v0**2)

# TODO: negative Frequenzen / und Fehlerfortpflanzung bei negativen Frequenzen bzw. dv = 0
for i in range(len(e_field_sq)):
  if e_field_sq[i].n <= 0:
    e_field_sq[i] = ufloat(0.0, e_field_sq[i].s)

e_field = unumpy.sqrt(e_field_sq)

for i in range(len(e_field)):
  if umath.isnan(e_field[i].s):
    e_field[i] = ufloat(e_field[i].n, np.sqrt(e_field_sq[i].s))


### Berechnung der Shuntimpedanz ###
# Instantane Spannung
x = unumpy.nominal_values(pos) / 1000.0
y = unumpy.nominal_values(e_field)
dy = unumpy.std_devs(e_field)

voltage = ufloat(*trapz(x, y, dy))

# Shunt-Impedanz (instantan)
rs = 0.5 * voltage**2

# Berechnung des Delay-Koeffizienten
c0 = 299792458.0 # Lichtgeschwindigkeit

# Phase definieren TODO: Schön machen
phase = np.zeros_like(x)
phase[0:74-7] = 0
phase[74-7:134-7] = np.pi
phase[134-7:194-7] = 0
phase[194-7:254-7] = np.pi
phase[254-7:314-7] = 0
phase[314-7:374-7] = np.pi
phase[374-7:434] = 0

def eff_voltage(phi0):
  harm_dep = unumpy.sin(2 * np.pi * v0 / c0 * x + phase + phi0)
  eff_field = e_field * harm_dep
  return trapz(x, unumpy.nominal_values(eff_field), unumpy.std_devs(eff_field))

def minimizer(phi0):
  x, y = eff_voltage(phi0)
  return -x

min_res = minimize_scalar(minimizer, bounds=(-np.pi, np.pi), method='bounded')
phi0 = min_res.x

effv = ufloat(*eff_voltage(phi0))

delay_coeff = effv / voltage

# effektive Beschleunigungsspannung
voltage_eff = voltage * delay_coeff

# effektive Shunt-Impedanz
rs_eff = rs * delay_coeff**2

### Abspeichern der Ergebnisse
field_out = np.column_stack((unumpy.nominal_values(pos), unumpy.std_devs(pos),
  unumpy.nominal_values(e_field), unumpy.std_devs(e_field)))

np.savetxt('feld.tsv', field_out, delimiter='\t')

