#!/bin/bash

# Check if .git directory exists

if [ -d ".git" ]; then
    echo "Git already initialized in this directory."
else
    echo "Initializing Git repository..."
    git init
fi

if [ -d ".venv" ] || [ -d "venv" ]; then
    echo "Virtual environment already exists."
else
    echo "Creating a virtual environment..."

    python3 -m venv .venv
fi

pip install -r requirements.txt

pip install -r requirements-dev.txt

pre-commit install 

pre-commit install --hook-type pre-push 

