# Install pipx
python -m pip install --user pipx
python -m pipx ensurepath

# Refresh environment to use pipx (may require restarting the shell)
$env:PATH += ";$env:USERPROFILE\.local\bin"

# Install jupyter_contrib_nbextensions using pipx
pipx install jupyter_contrib_nbextensions --include-deps

# Recursively list all .ipynb files inside the _posts directory
$notebooks = Get-ChildItem -Path "./_posts" -Recurse -Filter "*.ipynb" | Select-Object -ExpandProperty FullName

# Convert each Jupyter notebook to Jekyll markdown using the provided Python script
foreach ($notebook in $notebooks) {
    python notebooks/jupyter_to_jekyll.py $notebook
}
