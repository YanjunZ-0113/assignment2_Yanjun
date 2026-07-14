# Key Prompts for AI Linear Regression Project

The five prompts below are the most important for building and running the
command-line scripts (`linear_regression_python.py` and `linear_regression_r.R`).
They cover environment setup, script requirements, and the notebook analyses
that the scripts mirror.

---

## 1. Reproducible Environment Setup

Work only inside the current directory. Do not read, inspect, copy, compare, or
modify any files outside this directory, including the ../manual folder. Complete
this project independently from scratch. Create a reproducible environment for
both Python and R, including environment.yml, requirements.txt, and setup_env.sh.
Determine the required dependencies yourself, install them when necessary, and
keep the environment files synchronized with the packages actually used. Create
record.txt and append this prompt, all actions taken, commands executed,
dependencies installed, errors encountered, and files created or modified. Never
overwrite previous records and do not modify unrelated files.

---

## 2. Conda Environment Fix and Verification

The Conda environment regression-env was not created successfully. Running
`conda activate regression-env` returns `EnvironmentNameNotFound`. Diagnose the
problem, check environment.yml and setup_env.sh, create the environment
successfully, fix only the necessary environment files, verify with
`conda info --envs`, confirm Python and R in regression-env, test and run every
script under the conda environment.

---

## 3. Command-Line Scripts

Update Python and R command-line scripts to meet assignment requirements: rename
to linear_regression_python.py and linear_regression_r.R, accept
<filename> <x_column> <y_column>, save plots as linear_regression_python_output.png
and linear_regression_r_output.png, test with regression_data.csv YearsExperience
Salary, update README.md, append to record.txt.

---

## 4. Python Jupyter Notebook

Create and run linear_regression_python.ipynb using the Python kernel. Read and
display regression_data.csv, create a scatter plot of YearsExperience versus
Salary, fit a linear regression model, overlay the regression line, add titles
and axis labels, evaluate the model with R-squared, include short Markdown notes
for each step, preserve all outputs, and export it as linear_regression_python.html.

---

## 5. R Jupyter Notebook

Complete an R Jupyter Notebook analyzing regression_data.csv with simple linear
regression: display data, scatter plot, fit model, regression line, clear labels,
evaluate/summarize results, Markdown explanations, preserve outputs, export as
linear_regression_r.html.
