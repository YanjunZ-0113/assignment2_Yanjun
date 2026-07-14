#!/usr/bin/env bash
# Reproducible environment setup for Python and R regression project.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== Setting up regression project environment ==="

# Load conda from OSC miniconda module when not already on PATH.
if ! command -v conda >/dev/null 2>&1; then
  if type module >/dev/null 2>&1; then
    echo "Loading miniconda3 module..."
    module load miniconda3/24.1.2-py310
  fi
fi

if command -v conda >/dev/null 2>&1; then
  eval "$(conda shell.bash hook)"
  echo "Conda detected: $(conda --version)"

  if conda env list | awk '{print $1}' | grep -qx "regression-env"; then
    echo "Environment regression-env already exists. Updating from environment.yml..."
    conda env update -n regression-env -f environment.yml --prune
  else
    echo "Creating environment regression-env from environment.yml..."
    conda env create -f environment.yml
  fi

  conda activate regression-env
  echo "Active environment: $CONDA_DEFAULT_ENV"
  echo "Python: $(python --version)"
  echo "R: $(R --version | head -1)"
  echo "Registering R Jupyter kernel (ir_regression_env)..."
  R -q -e 'if (!requireNamespace("IRkernel", quietly = TRUE)) stop("IRkernel not installed"); IRkernel::installspec(name = "ir_regression_env", displayname = "R (regression-env)", user = TRUE)'
  echo "Activate with: module load miniconda3/24.1.2-py310 && conda activate regression-env"
else
  echo "ERROR: conda not found. Load miniconda3/24.1.2-py310 or install conda, then re-run."
  exit 1
fi

echo "=== Environment setup complete ==="
echo "Run Python analysis: python regression.py"
echo "Run R analysis:      Rscript regression.R"
echo "Run notebook:        jupyter nbconvert --to notebook --execute linear_regression_python.ipynb --inplace"
