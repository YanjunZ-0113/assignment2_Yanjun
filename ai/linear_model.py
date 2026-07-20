#!/usr/bin/env python3
"""Simple linear model from command-line arguments."""

import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score

PLOT_NAME = "regression_plot_python.png"


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
    pearson_r = float(np.corrcoef(data[x_column], data[y_column])[0, 1])
    mse = float(mean_squared_error(y, y_pred))
    r2 = float(r2_score(y, y_pred))

    print("Python Linear Model Results")
    print("===========================")
    print(f"File: {filename}")
    print(f"X column: {x_column}")
    print(f"Y column: {y_column}")
    print(f"Observations: {len(data)}")
    print(f"Slope ({x_column}): {slope:.4f}")
    print(f"Intercept: {intercept:.4f}")
    print(f"Pearson's r: {pearson_r:.6f}")
    print(f"MSE: {mse:.4f}")
    print(f"R-squared (optional): {r2:.6f}")

    fig, ax = plt.subplots(figsize=(9, 6))
    ax.scatter(data[x_column], data[y_column], color="steelblue", label="Observed")

    x_line = np.linspace(data[x_column].min(), data[x_column].max(), 100)
    ax.plot(x_line, intercept + slope * x_line, color="crimson", linewidth=2, label="Regression line")

    equation = f"{y_column} = {intercept:,.0f} + {slope:,.0f} * {x_column}"
    annotation = (
        f"{equation}\n"
        f"Pearson's r = {pearson_r:.4f}\n"
        f"MSE = {mse:,.0f}\n"
        f"R² = {r2:.4f}"
    )
    ax.text(
        0.05,
        0.95,
        annotation,
        transform=ax.transAxes,
        va="top",
        ha="left",
        bbox=dict(boxstyle="round,pad=0.5", facecolor="white", edgecolor="gray", alpha=0.9),
        fontsize=10,
    )

    ax.set_xlabel(x_column)
    ax.set_ylabel(y_column)
    ax.set_title(f"{y_column} vs {x_column} with Annotated Regression Line")
    ax.legend(loc="lower right")
    fig.tight_layout()

    plot_path = script_dir() / PLOT_NAME
    fig.savefig(plot_path, dpi=150)
    plt.close(fig)
    print(f"Plot saved to {plot_path}")


if __name__ == "__main__":
    main()
