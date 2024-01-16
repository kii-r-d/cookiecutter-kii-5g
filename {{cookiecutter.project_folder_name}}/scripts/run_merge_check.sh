# No argument runs refresh_venv.
if [ -z "$1" ]; then
    (echo "Refreshing venv & installing requirements..."; exit 0)
    bash scripts/refresh_venv.sh && (echo "☑ SUCCESSFUL"; exit 0) || { echo "☒ FAILED"; exit 1; }
# Script call argument does not do refresh, solely installs reqs.
elif [ "$1" == "script_call" ]; then
    (echo "Installing requirements..."; exit 0)
    python -m pip install -r requirements.txt
    (echo "Installing requirements-dev..."; exit 0)
    python -m pip install -r requirements-dev.txt
# Wrong argument throws an error.
else
    echo "FAILED. INVALID ARGUMENT PROVIDED."
    echo "USAGE: $0 [script_call]"
    exit 1
fi

path="{{cookiecutter.project_slug}}/"
(echo "Using BLACK to check reformatting..."; exit 0)
python -m black --check $path && (echo "☑ SUCCESSFUL"; exit 0) || { echo "☒ FAILED"; exit 1; }
(echo "Using RUFF to check linting..."; exit 0)
ruff check $path && (echo "☑ SUCCESSFUL"; exit 0) || { echo "☒ FAILED"; exit 1; }
(echo "Using MYPY to check type hinting..."; exit 0)
python -m mypy $path && (echo "☑ SUCCESSFUL"; exit 0) || { echo "☒ FAILED"; exit 1; }
(echo "Using PYTEST to check unit testing..."; exit 0)
python -m pytest tests/unit/ && (echo "☑ SUCCESSFUL"; exit 0) || { echo "☒ FAILED"; exit 1; }
(echo "Attempting package install..."; exit 0)
python -m pip install . && (echo "☑ SUCCESSFUL"; exit 0) || { echo "☒ FAILED"; exit 1; }