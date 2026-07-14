#!/usr/bin/env python3
"""Simple linear regression from command-line arguments."""

import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score

PLOT_NAME = "linear_regression_python_output.png"


def script_dir() -> Path:
    return Path(__file__).resolve().parent


def usage() -> None:
    print(f"Usage: {Path(sys.argv[0]).name} <filename> <x_column> <y_column>")
    sys.exit(1)


def main() -> None:
    if len(sys.argv) != 4:
        usage()

    filename, x_column, y_column = sys.argv[1:4]
    data_path = Path(filename)
    if not data_path.is_file():
        print(f"Error: file not found: {filename}")
        sys.exit(1)

    data = pd.read_csv(data_path)
    if x_column not in data.columns or y_column not in data.columns:
        print(f"Error: columns must exist in {filename}")
        print(f"Available columns: {', '.join(data.columns)}")
        sys.exit(1)

    x = data[[x_column]].values
    y = data[y_column].values

    model = LinearRegression()
    model.fit(x, y)
    y_pred = model.predict(x)

    slope = float(model.coef_[0])
    intercept = float(model.intercept_)
    r2 = float(r2_score(y, y_pred))
    rmse = float(np.sqrt(mean_squared_error(y, y_pred)))

    print("Python Linear Regression Results")
    print("================================")
    print(f"File: {filename}")
    print(f"X column: {x_column}")
    print(f"Y column: {y_column}")
    print(f"Observations: {len(data)}")
    print(f"Intercept: {intercept:.4f}")
    print(f"Slope ({x_column}): {slope:.4f}")
    print(f"R-squared: {r2:.6f}")
    print(f"RMSE: {rmse:.4f}")

    plt.figure(figsize=(8, 5))
    plt.scatter(data[x_column], data[y_column], color="steelblue", label="Observed")
    x_line = np.linspace(data[x_column].min(), data[x_column].max(), 100)
    plt.plot(x_line, intercept + slope * x_line, color="crimson", label="Regression line")
    plt.xlabel(x_column)
    plt.ylabel(y_column)
    plt.title(f"{y_column} vs {x_column}")
    plt.legend()
    plt.tight_layout()
    plot_path = script_dir() / PLOT_NAME
    plt.savefig(plot_path, dpi=150)
    plt.close()
    print(f"Plot saved to {plot_path}")


if __name__ == "__main__":
    main()
