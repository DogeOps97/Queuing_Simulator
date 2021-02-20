### Random Variate Generator for Uniform Distribution
#

import numpy as np
import random
import matplotlib.pyplot as plt

def rand_uniform(a, b, r):
    return a + (b - a) * r

results = []
py_rand = []

for i in range(10000):
    r = random.random()
    py_rand.append(r)
    results.append(rand_uniform(0, 100, r))

print("Mean : " + str(sum(results) / len(results)))

plt.hist(py_rand, bins = 100)
plt.title("Python Random Library")
fig = plt.figure()
plt.hist(results, bins = 100)
plt.title("Random Variate Generator for Exponential Distribution")


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