# Code Review: Assignment 3 PR (`maf/assignment3` vs `origin/main`)

**Review date:** 2026-07-20  
**Repository:** `/users/PAS3421/yanjun0113/assignment3`  
**Baseline:** `origin/main` (`ace4abaf`)  
**Branch:** `maf/assignment3` (`874fe918`)  
**Method:** `git fetch origin`, `git diff origin/main...HEAD`, script execution in `regression-env`, comparison against `manual/` as functional reference only

---

## PR Diff Scope

Single commit on branch: `874fe918 Complete Assignment 3 linear model deliverables for Python and R`

`git diff origin/main...HEAD --stat`: **32 files changed**, 5152 insertions, 2641 deletions.

| Area | Key changes |
|------|-------------|
| Root `README.md` | Assignment 2 guide replaced with short Assignment 3 pointer |
| `ai/` | Renamed `linear_regression_*` → `linear_model.*`; added notebooks, plots, docs; removed `requirements.txt`; updated `environment.yml` (+ `r-ggplot2`, `r-base` 4.5.3) and `setup_env.sh` echo commands |
| `manual/` | Same Assignment 3 renames and new `README.md` (reference only for this review) |

### `ai/` deliverables in the PR

| Required item | Present in PR | Notes |
|---------------|---------------|-------|
| `environment.yml` | Yes (modified) | Adds `r-ggplot2`; bumps `r-base` to 4.5.3 |
| `setup_env.sh` | Yes (modified) | Echo text updated to `linear_model.*` commands |
| `regression_data.csv` | Yes (unchanged) | Same 10-row dataset |
| `linear_model.py` | Yes (new) | CLI script with validation |
| `linear_model.R` | Yes (new) | CLI script with validation; ggplot2 plot |
| `linear_model_python.ipynb` | Yes (new) | Executed notebook with outputs |
| `linear_model_r.ipynb` | Yes (new) | Executed notebook; kernel `ir_regression_env` |
| `regression_plot_python.png` | Yes (new) | Saved by Python script |
| `regression_plot_r.png` | Yes (new) | Saved by R script |

Assignment 2 artifacts removed as expected: `linear_regression_*` scripts/notebooks/HTML/PNG files and `ai/requirements.txt` (dependencies now fully declared in `environment.yml`).

---

## Regression Calculations

Executed in `ai/` with `regression-env` activated:

```bash
python linear_model.py regression_data.csv YearsExperience Salary
Rscript linear_model.R regression_data.csv YearsExperience Salary
```

| Metric | `ai/` result | `manual/` reference | Expected (manual/README) |
|--------|--------------|---------------------|--------------------------|
| Slope | 8285.2921 | 8285.292 | ~8285.29 |
| Intercept | 29203.5227 | 29203.52 | ~29203.52 |
| Pearson's r | 0.886088 | 0.886088 | ~0.89 |
| MSE | 17523844.0829 | 17523844 | ~17523844.08 |

Both `ai/` scripts and both notebooks compute the same four statistics on the shared dataset. Methods differ from `manual/` (scikit-learn / `lm()` in `ai/` vs `scipy.stats.linregress` in manual Python) but agree numerically within rounding.

Notebook executed outputs confirm the same values (e.g. Python notebook Step 6: slope 8285.2921, intercept 29203.5227, r 0.886088, MSE 17523844.0829).

---

## Console Output

### Scripts

Both `ai/` scripts print all four required statistics plus optional R² and a plot path:

- Python: header block, `Slope (YearsExperience)`, `Intercept`, `Pearson's r`, `MSE`, `R-squared (optional)`
- R: matching structure with `cat()` output

This satisfies the Assignment 3 prompt requirement to print slope, intercept, Pearson's r, and MSE. Labels differ from the simpler `manual/` reference (`Correlation coefficient`, `Mean Squared Error`) but values match.

### Notebooks

Both notebooks print the four statistics in a compact form (`Slope:`, `Intercept:`, `Pearson's r:`, `MSE:`) without the script header/metadata block. Values match the scripts; format is slightly inconsistent but not incorrect.

---

## Command-Line Behavior

Both scripts accept `<filename> <x_column> <y_column>` as required.

Verified Python CLI handling:

- Wrong argument count → usage message, exit 1
- Missing file → `Error: file not found`, exit 1
- Invalid column → `Error: columns must exist` with available columns listed, exit 1

R script includes the same validation pattern. Usage strings correctly reference `linear_model.py` / `linear_model.R` (unlike stale usage strings still present in `manual/` reference scripts).

---

## Plot Annotations and Filenames

### Filenames

Scripts save plots next to the script as required:

- `regression_plot_python.png` (`linear_model.py`)
- `regression_plot_r.png` (`linear_model.R`)

Correct migration from Assignment 2 names (`linear_regression_*_output.png` on `origin/main`).

### Annotation content

All four implementations include an annotated regression equation plus Pearson's r, MSE, and R² on the final plot. Predicted values and residuals appear in notebook tables (Step 5 in both notebooks).

### R script and R notebook

`linear_model.R` and `linear_model_r.ipynb` both use ggplot2 with steelblue points, red `geom_abline`, and matching equation annotation. Axis label `Years of Experience`, title `Salary vs Years of Experience with Annotated Regression Line`.

---

## Issues Found

### Issue 1 — Python script plot labels inconsistent with R script, notebooks, and README

| Field | Detail |
|-------|--------|
| **Affected file** | `ai/linear_model.py` |
| **Issue** | The Python script sets `ax.set_xlabel(x_column)` and `ax.set_title(f"{y_column} vs {x_column} with Annotated Regression Line")`, producing **YearsExperience** on the axis and in the title. The R script special-cases `YearsExperience` → **Years of Experience**; both notebooks use **Years of Experience** on the x-axis and in the title. The saved `regression_plot_python.png` therefore does not match the labeled presentation in the Python notebook, R script, R notebook, or `manual/README.md` figure description. |
| **Importance** | **Medium (plot annotation / deliverable consistency).** Regression math and required statistics are correct, but the Python script PNG is the only deliverable that still exposes the raw column name instead of the human-readable axis label used everywhere else. |
| **Recommended fix** | Mirror the R script pattern in `linear_model.py`: derive `x_label = "Years of Experience" if x_column == "YearsExperience" else x_column`, use `x_label` for `set_xlabel` and in `set_title`; re-run the script and replace `regression_plot_python.png`. |
| **Resolution status** | **Resolved** — `linear_model.py` now maps `YearsExperience` to `Years of Experience` for the x-axis label and title; `regression_plot_python.png` regenerated. |

---

## What Passes Review

- PR diff correctly migrates `ai/` from Assignment 2 (`linear_regression_*`, RMSE/R² script output) to Assignment 3 (`linear_model.*`, Pearson's r/MSE, annotated plots)
- All four required statistics verified on `regression_data.csv` in scripts and notebooks
- CLI argument contract, validation, and usage strings are correct
- Plot filenames `regression_plot_python.png` and `regression_plot_r.png` are correct
- R script and R notebook use matching ggplot2 styling
- `environment.yml` includes `r-ggplot2`; `setup_env.sh` documents correct run commands
- `ai/` numerical results align with `manual/` functional reference

---

## Overall Assessment

The `maf/assignment3` PR is functionally sound: regression calculations, required console statistics, CLI behavior, output filenames, and Python plot axis/title labeling meet Assignment 3 requirements and align with the R and notebook deliverables.

---

## Resolution Tracker

| Item | Status |
|------|--------|
| Assignment 3 rename/migration in `ai/` | **Resolved** |
| Slope, intercept, Pearson's r, MSE verified | **Resolved** |
| CLI validation and usage strings | **Resolved** |
| `regression_plot_*.png` filenames | **Resolved** |
| R script/notebook ggplot2 alignment | **Resolved** |
| `environment.yml` + `setup_env.sh` updates | **Resolved** |
| Python script plot axis/title labels vs other deliverables | **Resolved** |
