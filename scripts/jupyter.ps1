# Install jupyter_contrib_nbextensions using pipx
pipx install jupyter --include-deps
pipx install jupyter_contrib_nbextensions

# Recursively list all .ipynb files inside the _posts directory
$notebooks = Get-ChildItem -Path "./_posts" -Recurse -Filter "*.ipynb" | Select-Object -ExpandProperty FullName

# Convert each Jupyter notebook to Jekyll markdown using the provided Python script
foreach ($notebook in $notebooks) {
    python notebooks/jupyter_to_jekyll.py $notebook
}
