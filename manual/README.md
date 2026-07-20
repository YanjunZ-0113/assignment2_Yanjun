# Assignment 3: Linear Regression Analysis

## Project Description

This project uses Python and R to perform a simple linear regression analysis between `YearsExperience` and `Salary`. Both versions calculate the slope, intercept, Pearson correlation coefficient, and Mean Squared Error, and generate an annotated regression plot.

## Environment Setup

From the `manual` folder, run:

```bash
bash setup_env.sh
```

## The project uses regression_data.csv and requires Python, R, pandas, matplotlib, scipy, scikit-learn, and ggplot2.

## Run the Python Script

```bash
python linear_model.py regression_data.csv YearsExperience Salary
```

## Run the R Script

```bash
Rscript linear_model.R regression_data.csv YearsExperience Salary
```

## Console Output

Both scripts print the following regression statistics:

- Slope: approximately `8285.29`
- Intercept: approximately `29203.52`
- Pearson correlation coefficient: approximately `0.89`
- Mean Squared Error: approximately `17523844.08`

## Output Figures

The scripts generate the following annotated regression plots:

- `regression_plot_python.png`
- `regression_plot_r.png`
