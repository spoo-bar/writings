# Install pipx
python -m pip install --user pipx
python -m pipx ensurepath

# Refresh environment to use pipx (may require restarting the shell)
$env:PATH += ";$env:USERPROFILE\.local\bin"

# Install jupyter_contrib_nbextensions using pipx
pipx install jupyter_contrib_nbextensions --include-deps

# Recursively list all .ipynb files inside the _posts directory
Get-ChildItem -Path "./_posts" -Recurse -Filter "*.ipynb" | Select-Object -ExpandProperty

python notebooks/jupyter_to_jekyll.py ./_posts/2025-06-10-rareskills-zk-bootcamp-pre-course-practise/2025-06-10-rareskills-zk-bootcamp-pre-course-practise.ipynb
