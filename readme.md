<h3> This is my personal toolkit that I use across various projects
<br>

## Installation

To install conda environment in current path, do:

```conda env create -p env -f setup.yml```

To update setup.yml, do:

```conda env export --no-builds -p env > environment.yml```

Remove conda environment, do:

`conda remove -p env --all`