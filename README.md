# Assignment 2: Linear Regression (Python and R)

This project performs simple linear regression on salary data (`regression_data.csv`)
to model the relationship between **YearsExperience** and **Salary**.

The repository contains two independent implementations:

| Folder   | Description |
|----------|-------------|
| `manual/` | Hand-written solution using the `7030_class_2` conda environment |
| `ai/`     | AI-assisted solution using the `regression-env` conda environment |

Both folders include:
- 2 command-line scripts (Python and R)
- 2 Jupyter notebooks (Python and R)
- Exported HTML notebooks
- Output plot PNG files from the scripts

---

## Project Structure

```
assignment2/
├── README.md                 # This file
├── manual/
|   ├──environment.yml         # Conda env for manual/ (7030_class_2)
|   ├──setup_env.sh            # Setup script for manual/
|   ├──requirement.txt         # Optional pip packages for manual/
│   ├── regression_data.csv
│   ├── linear_regression_python.py
│   ├── linear_regression_r.R
│   ├── linear_regression_python.ipynb
│   ├── linear_regression_r.ipynb
│   ├── linear_regression_python.html
│   ├── linear_regression_r.html
│   ├── linear_regression_python_output.png
│   └── linear_regression_r_output.png
└── ai/
    ├── regression_data.csv
    ├── linear_regression_python.py
    ├── linear_regression_r.R
    ├── linear_regression_python.ipynb
    ├── linear_regression_r.ipynb
    ├── linear_regression_python.html
    ├── linear_regression_r.html
    ├── linear_regression_python_output.png
    ├── linear_regression_r_output.png
    ├── environment.yml       # Conda env for ai/ (regression-env)
    ├── requirements.txt      # Pip fallback packages for ai/
    ├── setup_env.sh          # Setup script for ai/
    └── PROMPTS.md            # Key AI prompts used to build this folder
```

---

## Manual vs AI Differences

| Aspect | `manual/` | `ai/` |
|--------|-----------|-------|
| Conda environment | `7030_class_2` (Python 3.10) | `regression-env` (Python 3.11, R 4.5.2) |
| Script output | Scatter plot only | Intercept, slope, R², RMSE, and plot |
| Input validation | Basic usage check | File and column validation with error messages |
| PNG save location | Current working directory | Next to the script file |
| Python plot style | Blue points, red line | Steelblue points, crimson line with legend |
| R plotting | ggplot2 with green regression line | Base R with red regression line and legend |
| Notebooks | Short markdown notes per cell | Numbered step-by-step sections with outputs |
| Extra docs | — | `PROMPTS.md` |

---

## Prerequisites (OSC/Ascend)

On the OSC cluster, conda is provided through the miniconda module:

```bash
module load miniconda3/24.1.2-py310
```

Initialize conda in your shell session:

```bash
eval "$(conda shell.bash hook)"
```

Verify conda is available:

```bash
conda --version
conda info --envs
```

---

# Manual Version (`manual/`)

The manual solution uses the **`7030_class_2`** conda environment with Python 3.10,
JupyterLab, R, IRkernel, and ggplot2.

## 1. Environment Setup (Manual)

From the `assignment2/` root directory:

```bash
cd /users/PAS3421/yanjun0113/assignment2
module load miniconda3/24.1.2-py310
eval "$(conda shell.bash hook)"
```

### Option A: Automated setup (recommended)

```bash
bash setup_env.sh
```

This script:
1. Loads the miniconda module
2. Creates `7030_class_2` from `environment.yml`
3. Activates the environment
4. Installs pip packages from `requirement.txt` (pandas, matplotlib, scikit-learn)
5. Registers Jupyter kernels: `7030_class_2` and `ir_7030_class_2`
6. Starts JupyterLab on port 2000

### Option B: Manual setup steps

```bash
module load miniconda3/24.1.2-py310
eval "$(conda shell.bash hook)"

conda env create -f environment.yml
conda activate 7030_class_2
pip install -r requirement.txt

python -m ipykernel install --user --name 7030_class_2 --display-name "Python (7030_class_2)"
Rscript -e 'IRkernel::installspec(name="ir_7030_class_2", displayname="R (7030_class_2)")'
```

### Activate later

```bash
module load miniconda3/24.1.2-py310
eval "$(conda shell.bash hook)"
conda activate 7030_class_2
```

### Manual environment packages

| Package        | Purpose |
|----------------|---------|
| python=3.10    | Python runtime |
| jupyterlab     | Notebook interface |
| ipykernel      | Python Jupyter kernel |
| r-base         | R runtime |
| r-irkernel     | R Jupyter kernel |
| r-ggplot2      | R plotting (used by manual R script/notebook) |
| pandas, matplotlib, scikit-learn | Python analysis (via pip) |

---

## 2. Run Command-Line Scripts (Manual)

Change into the manual directory:

```bash
cd /users/PAS3421/yanjun0113/assignment2/manual
conda activate 7030_class_2
```

### Python script

```bash
python linear_regression_python.py regression_data.csv YearsExperience Salary
```

**Output:** `linear_regression_python_output.png` (saved in the current working directory)

**What it does:**
- Reads the CSV file
- Fits `LinearRegression` from scikit-learn
- Creates a scatter plot with a red regression line
- Saves the plot as PNG

### R script

```bash
Rscript linear_regression_r.R regression_data.csv YearsExperience Salary
```

**Output:** `linear_regression_r_output.png` (saved in the current working directory)

**What it does:**
- Reads the CSV file
- Fits `lm(y ~ x)`
- Creates a ggplot2 scatter plot with a green regression line
- Saves the plot as PNG

**Note:** The R script requires the **ggplot2** package (included in `7030_class_2`).

---

## 3. Run Jupyter Notebooks (Manual)

```bash
cd /users/PAS3421/yanjun0113/assignment2/manual
conda activate 7030_class_2
```

### Interactive JupyterLab

```bash
jupyter lab --no-browser --port=2000
```

Open in browser via SSH tunnel, then run:
- `linear_regression_python.ipynb` with kernel **Python (7030_class_2)**
- `linear_regression_r.ipynb` with kernel **R (7030_class_2)**

### Execute notebooks from command line

**Python notebook:**

```bash
jupyter nbconvert --to notebook --execute linear_regression_python.ipynb \
  --inplace --ExecutePreprocessor.kernel_name=7030_class_2
jupyter nbconvert --to html linear_regression_python.ipynb \
  --output linear_regression_python.html
```

**R notebook:**

```bash
jupyter nbconvert --to notebook --execute linear_regression_r.ipynb \
  --inplace --ExecutePreprocessor.kernel_name=ir_7030_class_2
jupyter nbconvert --to html linear_regression_r.ipynb \
  --output linear_regression_r.html
```

### Manual notebook summary

| Notebook | Kernel | Key steps |
|----------|--------|-----------|
| `linear_regression_python.ipynb` | Python (7030_class_2) | Import libraries, read data, scatter plot, fit model, plot regression line, print R² |
| `linear_regression_r.ipynb` | R (7030_class_2) | Read data, base R scatter, fit `lm()`, ggplot2 regression plot, `summary(model)` |

---

# AI Version (`ai/`)

The AI solution uses the **`regression-env`** conda environment with Python 3.11,
R 4.5.2, Jupyter, and analysis packages managed through `ai/environment.yml`.

## 1. Environment Setup (AI)

```bash
cd /users/PAS3421/yanjun0113/assignment2/ai
module load miniconda3/24.1.2-py310
eval "$(conda shell.bash hook)"
```

### Option A: Automated setup (recommended)

```bash
bash setup_env.sh
```

This script:
1. Loads the miniconda module if conda is not on PATH
2. Creates or updates `regression-env` from `ai/environment.yml`
3. Activates the environment
4. Prints Python and R versions

### Option B: Manual setup steps

```bash
module load miniconda3/24.1.2-py310
eval "$(conda shell.bash hook)"

conda env create -f environment.yml
conda activate regression-env
```

If the environment already exists:

```bash
conda env update -n regression-env -f environment.yml --prune
conda activate regression-env
```

### Register R Jupyter kernel (if needed)

```bash
conda activate regression-env
Rscript -e 'IRkernel::installspec(name="ir_regression_env", displayname="R (regression-env)")'
```

### Activate later

```bash
module load miniconda3/24.1.2-py310
eval "$(conda shell.bash hook)"
conda activate regression-env
```

### AI environment packages

| Package | Version | Purpose |
|---------|---------|---------|
| python | 3.11 | Python runtime |
| numpy | 2.4.6 | Numerical computing |
| pandas | 2.3.3 | Data handling |
| scikit-learn | 1.6.1 | Linear regression |
| matplotlib | 3.11.0 | Python plotting |
| r-base | 4.5.2 | R runtime |
| jupyter, nbconvert, ipykernel | latest | Notebooks |
| r-irkernel | (via conda) | R Jupyter kernel |

### Verify environment

```bash
conda info --envs
conda activate regression-env
python --version
R --version
python -c "import pandas, sklearn, matplotlib; print('Python packages OK')"
Rscript -e 'cat("R OK\n")'
```

---

## 2. Run Command-Line Scripts (AI)

```bash
cd /users/PAS3421/yanjun0113/assignment2/ai
conda activate regression-env
```

### Python script

```bash
python linear_regression_python.py regression_data.csv YearsExperience Salary
```

**Output:** `linear_regression_python_output.png` (saved next to the script)

**What it does:**
- Validates file and column names
- Fits linear regression with scikit-learn
- Prints intercept, slope, R², and RMSE
- Saves a labeled scatter plot with legend

### R script

```bash
Rscript linear_regression_r.R regression_data.csv YearsExperience Salary
```

**Output:** `linear_regression_r_output.png` (saved next to the script)

**What it does:**
- Validates file and column names
- Fits `lm(Salary ~ YearsExperience)`
- Prints intercept, slope, R², and RMSE
- Saves a base R scatter plot with red regression line and legend

---

## 3. Run Jupyter Notebooks (AI)

```bash
cd /users/PAS3421/yanjun0113/assignment2/ai
conda activate regression-env
```

### Interactive JupyterLab

```bash
jupyter lab --no-browser --port=2001
```

Open notebooks with:
- `linear_regression_python.ipynb` → kernel **Python 3 (ipykernel)** (`python3`)
- `linear_regression_r.ipynb` → kernel **R (regression-env)** (`ir_regression_env`)

### Execute notebooks from command line

**Python notebook:**

```bash
jupyter nbconvert --to notebook --execute linear_regression_python.ipynb \
  --inplace --ExecutePreprocessor.kernel_name=python3
jupyter nbconvert --to html linear_regression_python.ipynb \
  --output linear_regression_python.html
```

**R notebook:**

```bash
jupyter nbconvert --to notebook --execute linear_regression_r.ipynb \
  --inplace --ExecutePreprocessor.kernel_name=ir_regression_env
jupyter nbconvert --to html linear_regression_r.ipynb \
  --output linear_regression_r.html
```

### AI notebook summary

| Notebook | Kernel | Key steps |
|----------|--------|-----------|
| `linear_regression_python.ipynb` | python3 | 6 steps: import, display data, scatter, fit model, overlay line, R² |
| `linear_regression_r.ipynb` | ir_regression_env | 5 steps: load data, scatter, fit model, regression line plot, model summary |

---

## Expected Results

Both implementations analyze the same dataset and should produce equivalent
regression statistics:

| Metric | Expected value |
|--------|----------------|
| Intercept | 29203.52 |
| Slope | 8285.29 |
| R-squared | 0.785152 |
| RMSE | 4186.15 |

The manual scripts do not print these statistics to the terminal; the AI scripts
and notebooks do.

---

## Output Files

| File | Created by | Location |
|------|------------|----------|
| `linear_regression_python_output.png` | Python script | `manual/`: cwd; `ai/`: next to script |
| `linear_regression_r_output.png` | R script | `manual/`: cwd; `ai/`: next to script |
| `linear_regression_python.html` | Notebook export | Same folder as notebook |
| `linear_regression_r.html` | Notebook export | Same folder as notebook |

---

## Quick Reference

### Manual (7030_class_2)

```bash
cd /users/PAS3421/yanjun0113/assignment2/manual
bash setup_env.sh                          # one-time setup
conda activate 7030_class_2
python linear_regression_python.py regression_data.csv YearsExperience Salary
Rscript linear_regression_r.R regression_data.csv YearsExperience Salary
```

### AI (regression-env)

```bash
cd /users/PAS3421/yanjun0113/assignment2/ai
bash setup_env.sh                          # one-time setup
conda activate regression-env
python linear_regression_python.py regression_data.csv YearsExperience Salary
Rscript linear_regression_r.R regression_data.csv YearsExperience Salary
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `conda: command not found` | Run `module load miniconda3/24.1.2-py310` |
| `EnvironmentNameNotFound` | Create env with `bash setup_env.sh` in the correct folder |
| R script fails on ggplot2 (manual) | Activate `7030_class_2`; ggplot2 is in `environment.yml` |
| Notebook plots not showing (AI Python) | Use `%matplotlib inline`; do not force Agg backend in notebooks |
| `FigureCanvasAgg` warning | Remove `matplotlib.use("Agg")` from notebook cells |
| Output PNG not beside script (manual) | Manual scripts save to cwd; run from `manual/` or use full paths |
| R kernel not found | Register with `IRkernel::installspec()` in the active conda env |

---

## Additional Documentation

- **AI prompts:** `ai/PROMPTS.md` — key prompts used to build the AI implementation
