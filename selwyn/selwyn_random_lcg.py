### LCG
# https://arxiv.org/pdf/2001.05304.pdf


import time
import matplotlib.pyplot as plt
import random

# results = [int(time.time())]
results = [random.randint(0, 100)]

def lcg(m, a, c, x_0):
    return (a * x_0 + c) % m

for i in range(100):
    # results.append(lcg(2 ** 32, 5, 1, results[i]))
    # results.append(lcg(2 ** 32, 3472989573, 1, results[i]))
    results.append(lcg(100, 5, 1, results[i]))

del results[0]

plt.hist(results, bins = 100)

# Spectral test
# https://en.wikipedia.org/wiki/Spectral_test
# make 2D and 3D plots

from mpl_toolkits.mplot3d import Axes3D

results_y = [0] + results[:-1]
results_z = [0, 0] + results[:-2]

# 2D Scatter plot
fig = plt.figure()
plt.scatter(results, results_y)

# 3D Scatter Plot
fig = plt.figure()
ax = plt.axes(projection='3d')
ax.scatter3D(results, results_y, results_z)
plt.show()