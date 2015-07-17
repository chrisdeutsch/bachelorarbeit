import numpy as np

data = np.loadtxt("guete_eval.tsv")

v0 = data[:, 0]
Q0 = data[:, 2]
k = data[:, 4]

# Mittelwerte
v0_mean = v0.mean()
Q0_mean = Q0.mean()
k_mean = k.mean()

# Standardabweichungen
v0_stddev = v0.std(ddof=1)
Q0_stddev = Q0.std(ddof=1)
k_stddev = k.std(ddof=1)

with open("guete_mittel.txt", "w") as f:
  f.write("""v0 = {} +- {} Hz
Q0 = {} +- {}
k = {} +- {}
""".format(v0_mean, v0_stddev, Q0_mean, Q0_stddev, k_mean, k_stddev))
