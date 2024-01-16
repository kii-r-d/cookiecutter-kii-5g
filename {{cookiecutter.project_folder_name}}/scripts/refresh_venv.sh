python -m pip freeze > temp-requirements.txt
python -m pip uninstall -r temp-requirements.txt -y
rm temp-requirements.txt
python -m pip install -r requirements.txt
python -m pip install -r requirements-dev.txt