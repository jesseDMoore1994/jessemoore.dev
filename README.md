# Source code for jessemoore.dev

This is the source repository for jessemoore.dev. Created using pelican.

# Using the project.
## Dependencies
To use the project the following dependencies must be satisfied.
* virtualenv
* Pelican

## Get the source code.
git clone git@github.com:jesseDMoore1994/jessemoore.dev.git

## Installing dependencies

Install virtualenv using a preferred method, in my case, it was ubuntu. So I used

```
python3 -m pip install --user virtualenv
sudo apt install python3.8-venv
```

once that is installed, navigate to your cloned repository and install pelican in a virtual environment

## Generating the webite
```
make output
```

## Hosting the static site locally.
```
make host
```
Open a web browser and navigate to http://127.0.0.1:8000 to view it

## Thanks to the following projects for their contributive components of this website.

[Pelican](https://github.com/getpelican/pelican)
[monospace](https://github.com/getpelican/pelican-themes/tree/master/monospace)
[github actions](https://docs.github.com/en/actions)
[google domains](https://domains.google/)
[gh-pages-pelican-action](https://github.com/nelsonjchen/gh-pages-pelican-action)
