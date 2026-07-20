# Code Review: Assignment 3 vs GitHub `main`

**Review date:** 2026-07-20  
**Local path:** `/users/PAS3421/yanjun0113/assignment3`  
**Remote baseline:** [https://github.com/YanjunZ-0113/assignment2_Yanjun.git](https://github.com/YanjunZ-0113/assignment2_Yanjun.git) — branch `main`  
**Comparison:** entire working tree (`README.md`, `ai/`, `manual/`) vs `origin/main`  
**Method:** `git fetch origin`, `git diff origin/main`, untracked inventory, script execution

---

## Remote Verification

```bash
git remote get-url origin
# https://github.com/YanjunZ-0113/assignment2_Yanjun.git

git fetch origin
git rev-parse HEAD origin/main
# ace4abaf (local main even with GitHub main)
```

All diffs are against **`origin/main` on that repository**.

---

## Diff Scope (whole repository)

`git diff origin/main...HEAD` is **empty** — Assignment 3 work is uncommitted.
The full delta is the **working tree** plus **untracked files**:

| Scope | Tracked diff | Untracked |
|-------|--------------|-----------|
| `README.md` | Rewritten (A2 → A3) | — |
| `ai/` | 3 modified, 9 deleted | 10 files |
| `manual/` | 8 deleted | 9 files |
| `.gitignore` | Unchanged | — |
| **Total** | 21 paths, ~36k deletions (mostly HTML) | 19 new files |

---

## Root: `README.md`

| | GitHub `main` | Local Assignment 3 |
|---|---------------|-------------------|
| Title | Assignment 2: Linear Regression | Assignment 3: Linear Model |
| Content | Full A2 setup, structure, instructions (~480 lines) | Short pointer to `manual/README.md` and `ai/README_AI.md` |

Expected migration — not a defect.

---

## `manual/` vs GitHub `main`

### On GitHub `main` (`manual/`)

```
manual/
├── environment.yml
├── setup_env.sh
├── requirement.txt
├── regression_data.csv
├── linear_regression_python.py
├── linear_regression_python.ipynb
├── linear_regression_python.html
├── linear_regression_python_output.png
├── linear_regression_r.R
├── linear_regression_r.ipynb
├── linear_regression_r.html
└── linear_regression_r_output.png
```

### Local Assignment 3 (`manual/`)

**Unchanged from GitHub `main` (still tracked, no diff):**

- `environment.yml`, `setup_env.sh`, `requirement.txt`, `regression_data.csv`

**Removed in tracked diff (Assignment 2 artifacts):**

- All `linear_regression_*` scripts, notebooks, HTML exports, and `*_output.png` files

**Added (untracked — Assignment 3 replacements):**

| File | Role |
|------|------|
| `README.md` | Manual folder documentation |
| `linear_model.py`, `linear_model.R` | CLI scripts |
| `linear_model_python.ipynb`, `linear_model_r.ipynb` | Notebooks |
| `linear_model_python.html`, `linear_model_r.html` | HTML exports |
| `regression_plot_python.png`, `regression_plot_r.png` | Script plot outputs |

Assignment 2 → 3 renames in `manual/` mirror `ai/` and are **expected**, not defects.

### `manual/` functional review

```bash
Rscript linear_model.R regression_data.csv YearsExperience Salary
```

| Metric | `manual/` | `ai/` |
|--------|-----------|-------|
| Slope | 8285.292 | 8285.2921 |
| Intercept | 29203.52 | 29203.5227 |
| Pearson's r | 0.886088 | 0.886088 |
| MSE | 17523844 | 17523844.0829 |

R results match `ai/` within rounding. Python script uses `scipy.stats.linregress`
and saves `regression_plot_python.png`; R uses `ggplot2` with `geom_smooth`.

**Minor `manual/` inconsistency (not an `ai/` defect):** `linear_model.py` and
`linear_model.R` still print stale Assignment 2 names in usage strings
(`linear_regression_python.py`, `linear_regression_r.R`) even though files were
renamed to `linear_model.*`.

---

## `ai/` vs GitHub `main`

### On GitHub `main` (`ai/`)

```
ai/
├── environment.yml
├── setup_env.sh
├── requirements.txt
├── regression_data.csv
├── linear_regression_python.py
├── linear_regression_python.ipynb
├── linear_regression_python.html
├── linear_regression_python_output.png
├── linear_regression_r.R
├── linear_regression_r.ipynb
├── linear_regression_r.html
└── linear_regression_r_output.png
```

### Local changes

**Modified (tracked):**

| File | Change |
|------|--------|
| `environment.yml` | `r-base` 4.5.2 → 4.5.3; added `r-ggplot2` |
| `setup_env.sh` | Echo commands updated to `linear_model.*` |
| `PROMPTS.md` | Rewritten for Assignment 3 |

**Removed (tracked):** all Assignment 2 `linear_regression_*` files and `requirements.txt`

**Added (untracked):**

| File | Role |
|------|------|
| `linear_model.py`, `linear_model.R` | CLI scripts |
| `linear_model_python.ipynb`, `linear_model_r.ipynb` | Notebooks |
| `regression_plot_python.png`, `regression_plot_r.png` | Plot outputs |
| `README_AI.md`, `CODE_REVIEW.md`, `PROMPTS.md` | Docs |
| `linear_model_python.html`, `linear_model_r.html` | Optional exports |

**Unchanged:** `regression_data.csv`

### Required `ai/` deliverables

| Required file | Working tree | GitHub `main` | In PR diff? |
|---------------|--------------|---------------|-------------|
| `environment.yml` | Yes (modified) | Yes | Yes |
| `setupenv.sh` | **No** — `setup_env.sh` | `setup_env.sh` | Name unchanged |
| `regression_data.csv` | Yes | Yes | No change |
| `linear_model.py` | Yes | No | Untracked |
| `linear_model.R` | Yes | No | Untracked |
| `linear_model_python.ipynb` | Yes | No | Untracked |
| `linear_model_r.ipynb` | Yes | No | Untracked |
| `regression_plot_python.png` | Yes | No | Untracked |
| `regression_plot_r.png` | Yes | No | Untracked |

---

## `ai/` vs `manual/` (functional comparison)

Both folders implement the same Assignment 3 linear model on `regression_data.csv`.

| Aspect | `manual/` | `ai/` |
|--------|-----------|-------|
| Python method | `scipy.stats.linregress` | `sklearn.LinearRegression` |
| R method | `lm()` + `cor()` + residual MSE | Same |
| CLI args | `<filename> <x_column> <y_column>` | Same |
| Input validation | Minimal | File + column checks |
| Usage string | Stale A2 filenames | Correct `linear_model.*` |
| Plot filenames | `regression_plot_*.png` | Same |
| Python plot | matplotlib, simple annotation | matplotlib, richer annotation + legend |
| R plot | ggplot2 `geom_smooth` (green) | ggplot2 `geom_abline` (red) |
| Console output | Basic four stats | Four stats + optional R² + metadata |
| Environment | `7030_class_2` + `requirement.txt` | `regression-env` (conda-only) |

Regression results agree on the shared dataset. `ai/` is more verbose and validated;
`manual/` is the hand-written reference baseline.

---

## Review of `ai/` (graded deliverables)

### Regression calculations

Verified by execution on `regression_data.csv`:

```
Slope:        8285.2921
Intercept:    29203.5227
Pearson's r:  0.886088
MSE:          17523844.0829
```

### Console output, CLI, plots, filenames

- All four required statistics printed in scripts and notebooks
- CLI accepts and validates filename and column arguments
- Annotated plots saved as `regression_plot_python.png` and `regression_plot_r.png`
- R script and R notebook both use ggplot2 with matching styling
- Assignment 3 filenames used throughout; Assignment 2 names removed

---

## Issues Found

### Issue 1 — `ai/setup_env.sh` does not match required `setupenv.sh`

| Field | Detail |
|-------|--------|
| **Affected file** | `ai/setup_env.sh` (required: `ai/setupenv.sh`) |
| **Issue** | Official Assignment 3 requires `setupenv.sh`. GitHub `main` and local tree use `setup_env.sh` in both `ai/` and `manual/`. |
| **Importance** | **High (`ai/` deliverable compliance).** |
| **Recommended fix** | Rename `ai/setup_env.sh` to `setupenv.sh`; update `README_AI.md` and echo text; re-test. |
| **Resolution status** | **Open** |

---

## What Passes Review

- Baseline is GitHub `main` at `https://github.com/YanjunZ-0113/assignment2_Yanjun.git`
- Whole repo compared: `README.md`, `ai/`, and `manual/`
- Assignment 2 → 3 migration consistent in both folders
- `manual/` R script verified; stats match `ai/`
- `ai/` scripts, notebooks, and plots functionally correct
- `ai/` usage strings and validation stronger than `manual/`

---

## Overall Assessment

Local `/users/PAS3421/yanjun0113/assignment3` correctly migrates **both** `ai/` and
`manual/` from GitHub `main` Assignment 2 artifacts to Assignment 3 linear-model
deliverables. `ai/` is functionally correct and aligns with `manual/` on regression
results. Main open item: **`setupenv.sh` filename in `ai/`**. All new Assignment 3
files in both folders remain **untracked** until committed.

---

## Resolution

| Item | Status |
|------|--------|
| Baseline = GitHub repo above, branch `main` | **Resolved** |
| Whole repo review including `manual/` | **Resolved** |
| `manual/` Assignment 3 files present (untracked) | **Resolved** (local) |
| `ai/` scripts/notebooks/plots verified | **Resolved** (local) |
| `environment.yml` — `r-base=4.5.3`, `r-ggplot2` | **Resolved** (tracked) |
| `ai/setup_env.sh` echo commands fixed | **Resolved** (tracked) |
| `ai/linear_model.R` ggplot2 aligned with notebook | **Resolved** (untracked) |
| `ai/setupenv.sh` rename | **Open** |
| Assignment 3 files committed for complete PR diff | **Open** |
