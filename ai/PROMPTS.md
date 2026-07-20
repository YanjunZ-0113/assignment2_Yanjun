# AI Prompts Used in Assignment 3 (`ai/`)

The prompts below are the main ones used to build and document the `ai/` deliverables.

---

## 1. Python Analysis

Update the existing `ai/linear_regression_python.ipynb` and `ai/linear_regression_python.py`. Rename them to `ai/linear_model_python.ipynb` and `ai/linear_model.py`. In both files, print slope, intercept, Pearson's r, and MSE; include predicted values and an annotated regression plot, with brief Markdown explanations in the notebook. Make the script run as:

```bash
python linear_model.py regression_data.csv YearsExperience Salary
```

Save the plot as `regression_plot_python.png`. Do not create duplicate files or modify the manual folder.

---

## 2. R Analysis

Update the existing `ai/linear_regression_r.ipynb` and `ai/linear_regression_r.R`. Rename them to `ai/linear_model_r.ipynb` and `ai/linear_model.R`. In both files, print slope, intercept, Pearson's r, and MSE; include predicted values and an annotated ggplot2 regression plot, with brief Markdown explanations in the notebook. Use ggplot2 in both the script and notebook so they produce matching plots. Make the script run as:

```bash
Rscript linear_model.R regression_data.csv YearsExperience Salary
```

Save the plot as `regression_plot_r.png`. Run all notebook cells, export `ai/linear_model_r.html`, and do not create duplicate files or modify the manual folder.

---

## 3. Documentation Prompts

### AI commit message

Review the completed changes in assignment2 and assignment3 and generate one clear Git commit message describing the updated Python and R notebooks, standalone scripts, regression statistics, annotated plots, and output files. Provide only the commit message and do not modify any files.

### AI code review

Review the current assignment3 branch changes compared with main. Check the Python and R notebooks and scripts for correct slope, intercept, Pearson's r, MSE, command-line arguments, plot annotations, filenames, and assignment requirements. Identify at least one meaningful issue and save the review as `ai/CODE_REVIEW.md`. Include the affected file, the issue, its importance, and the recommended fix. Do not modify the manual folder.

### AI-generated README

Generate a fresh README based on the completed files in the `ai` folder and save it as `ai/README_AI.md`. Include the project purpose, dataset description, file descriptions, environment setup, commands for running the Python and R scripts, explanations of slope, intercept, Pearson's r, and MSE, and descriptions of the output plots. Do not modify `README.md` or `manual/README.md`.
