Title: Powered By Pelican
Date: 2021-09-13 02:30
Tags: Pelican
Lang: en
Slug: powered-py-pelican

##Introduction

This blog was created as a place for me to technical writeups of things I have done that may be of interest
to others. I suppose a Hello World! is in order!

In addition, it was created as a learning experiment with github actions, github pages, and pelican. The following
is a writeup that details how I used those tools in order to build this website.

I would like to suggest going to view the README.md on github which details the process for developing the webite.
This page is the published version of the output created in the main branch here.

[https://github.com/JesseDMoore1994/jessemoore.dev](https://github.com/JesseDMoore1994/jessemoore.dev)


##Pelican

Pelican is a pretty neat tool, you can give it a tree of content and it renders it into a statically built website.

    ➜  jessemoore.dev git:(main) ✗ tree content
    content
    ├── pages
    │   └── about.rst
    └── pelican
        └── powered-by-pelican.rst

Boy that sure is a lot of folders, what do they do?

* The pages folder is used to host pages that are not directly blog posts, think like contact info, resume, other
	platforms, etc.
* The pelican folder is a category folder to host articles, this article you are reading currently is in that category.

In the future I will likely be adding a folder for each new category, an images folder to store all my images, and more.

While I am working on the project incrementally, be it adjusting theme or adding new articles, I use the following
command in order to build and display the render locally:

```bash
   make clean && make output && make host
```

This is the simple makefile that I just use to do some housekeeping.

```bash
  # [main x] {} jessemoore.dev cat Makefile
  VENV?=venv
  VENV_ACTIVATE=. $(VENV)/bin/activate
  PYTHON=$(VENV)/bin/python3
  OUTPUT_FOLDER=$

  $(VENV)/bin/activate: requirements.txt
          python3 -m venv $(VENV)
          ./$(VENV)/bin/pip install -r requirements.txt

  output: $(VENV)/bin/activate
          . $(VENV)/bin/activate && pelican content

  host:
          . $(VENV)/bin/activate && pelican -l output

  clean:
          rm -rf output

  clean-all:
          rm -rf venv output

  .PHONY: clean clean-all host
```

This way I can view what my changes look like before checking them into main.

*Note:*
    *To get the themeing displayed locally I have*
    *to uncomment the RELATIVE_URLS=True variable*
    *in pelicanconf.py. I comment it back out*
    *before I push to main so everything links*
    *correctly in pages.*

#Deployment

I deploy this website automatically to github pages via github actions from [gh-pages-pelican-action](https://github.com
/nelsonjchen/gh-pages-pelican-action). Luckily there was already an existing action that did exactly what I wanted it
to with just a few tweaks before using it. I just had create a config file for github to wrap it around my project. I
used the config file from example project for gh-pages-pelican-action as the base for this one.

```yml
	➜  jessemoore.dev git:(main) ✗ cat .github/workflows/pelican.yml
	name: Pelican site CI

	on:
	  # Trigger the workflow on push or pull request,
	  # but only for the master branch
	  push:
	    branches:
	      - main

	jobs:
	  build:

	    runs-on: ubuntu-latest

	    steps:
	    - name: Checkout source repository
	      uses: actions/checkout@v2
	      with:
	        submodules: true
	    - uses: JesseDMoore1994/gh-pages-pelican-action@0.1.10
	      env:
	        GITHUB_TOKEN: ${{secrets.GITHUB_TOKEN}}
```

By doing this, whenever I submit code to the main branch of my repository, the code is checked out, then the action
at version [0.1.10](https://github.com/jesseDMoore1994/gh-pages-pelican-action/tree/0.1.10>) on my github is used to
deploy the output to the gh-pages branch.

Make sure to follow the [instructions](https://docs.github.com/en/pages/getting-started-with-github-pages/
creating-a-github-pages-site) for setting up github pages on your repository.

##How did you get a domain?

I use google domains to redirect traffic from [https://jessemoore.dev](https://jessemoore.dev>) to
[https://jessedmoore1994.github.io/jessemoore.dev]([https://jessedmoore1994.github.io/jessemoore.dev]).
Check out google domains [here](https://domains.google.com). I also have email forwarding for the domain, so please
shoot me one if you feel the need using jesse@jessemoore.dev.

##Creating this article!

To create this article, I created the following rst called pelican.rst to the [pelican category folder](https://github.com/jesseDMoore1994/pelican-test/tree/main/content/pelican) mentioned earlier. Thats it! One article
down! 😊

##Creating non-blog content!

You can create non-blog content too, I created the following rst called about.rst in the [pages folder](https://github.com/jesseDMoore1994/pelican-test/tree/main/content/pages). I will soon be updating it to include
more about myself, post socials, etc. I also want to create a page to host my resume.
