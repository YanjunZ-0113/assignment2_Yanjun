#!/usr/bin/env python
# coding: utf-8

# This notebook demonstrates a simple linear regression analysis using python to model Salary based on Years of Experience.

import sys
import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import linregress
from sklearn.metrics import mean_squared_error

if len(sys.argv) != 4:
    print("Usage: python linear_model.py <filename> <x_column> <y_column>")
    sys.exit(1)

filename = sys.argv[1]
x_title = sys.argv[2]
y_title = sys.argv[3]

dataset = pd.read_csv(filename)
x = dataset[x_title]
y = dataset[y_title]

# Linear regression
slope, intercept, r_value, p_value, std_err = linregress(x, y)
y_pred = slope * x + intercept
mse = mean_squared_error(y, y_pred)

print("Slope:", slope)
print("Intercept:", intercept)
print("Correlation coefficient:", r_value)
print("Mean Squared Error:", mse)

# Plot
plt.scatter(x, y, color="blue")
plt.plot(x, y_pred, 'r-', label='Fitted Line')
plt.text(1.5, max(y) - 14000,
         f"y = {slope:.2f}x + {intercept:.2f}\n"
         f"r = {r_value:.2f}\nMSE = {mse:.2f}",
         fontsize=12)
plt.xlabel(x_title)
plt.ylabel(y_title)
plt.title("Regression")
plt.legend()
plt.savefig("regression_plot_python.png")
plt.show()
