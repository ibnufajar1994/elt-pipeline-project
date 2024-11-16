#!/bin/bash

echo "========== Start Orcestration Process =========="

# Virtual Environment Path
VENV_PATH="your-project-directory/.venv/bin/activate"

# Activate Virtual Environment
source "$VENV_PATH"

# Set Python script
PYTHON_SCRIPT="your-project-directory/elt_main.py"

# Run Python Script 
python3 "$PYTHON_SCRIPT"


echo "========== End of Orcestration Process =========="
