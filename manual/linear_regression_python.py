#!/usr/bin/env python
# coding: utf-8

# This notebook demonstrates a simple linear regression analysis using python to model Salary based on Years of Experience.

import sys
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

if len(sys.argv) != 4:
    print("Usage: python linear_regression_python.py <filename> <x_column> <y_column>")
    sys.exit(1)

filename = sys.argv[1]
x = sys.argv[2]
y = sys.argv[3]

dataset = pd.read_csv(filename)

model = LinearRegression()
model.fit(dataset[[x]], dataset[[y]])

plt.scatter(dataset[x], dataset[y], color="blue")
plt.plot(dataset[[x]], model.predict(dataset[[x]]), color="red")
plt.title(f'{x} vs {y}')
plt.xlabel(x)
plt.ylabel(y)
plt.savefig("linear_regression_python_output.png")
plt.show()