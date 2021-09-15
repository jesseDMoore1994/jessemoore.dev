An interesting GNU Make feature
###############################

:tags: Make
:date: 2021-09-14
:lang: en
:slug: make-SHELL-issue

Background
**********

I find that make is one of those tools that I actually need to sit down and read the manual for, but I don't think I'll
ever have the time or attention span to do so. The topic itself is interesting, I would be particularly iterested if
there were some interactive programming challenges or other interactive forms of make training that is interactive.
I know a fair bit (At least, I think I do) about makefiles and I feel relatively comfortable with Make.

But...

There is always something with make, once you think you are finally safe from shooting yourself in the foot, you will
find a way to do it again. One of my primary complaints when it comes to make is that when it fails, there are rarely
good answers to the fundamental questions of *how* or *why* the failure is occurring. Sometimes make fails in ways
that might even mislead you to other parts of your projects, such as in this following case.

The Make Feature
****************
The make feature in question is ``SHELL``. For those who know about ``SHELL``, ``SHELL`` is a special variable in gnu
make that is used to define the shell you want to use for your execution of the make recipies in that makefile.

.. code-block:: make

    SHELL ?= /bin/sh

    test:
        # This file touch is run in $(SHELL)
        touch test

That, in and of itself, I have no strong problems with. In fact, I could find it to be useful if I needed to exploit the
features of a new shell during my build process. That said, when I started work today, I did **NOT** know, about this
feature at all. I think we know where this is going...

How it Happened
***************
Much of my build process at work is docker containers, they are just too convenvient for reproducability. In that way,
Make and docker interact quite frequently at least in my present experience. It is not uncommon for me to use make to
drive some collection of docker commands. Not only are a lot of our projects themselves docker containers, but most of
our tooling is in docker containers too. One of my favorite tools that has a docker container is ``jq``. I find it to
be a useful tool when trying to incorporate some more structured data into some element of the pipeline. Many projects
produce json reports that can be used to receive information about the operation that it just performed, or maybe
there is some information that comes as part of a build output. In environments like Jenkins in my case, someone else is
maintaining the executors so I can't just install whatever I want on it. Luckily, docker is installed on them, so if
there is a tool that I need in my build process I can containerize it and use it in the CI/CD pipeline.

I was working on creating such a project for work. It is a tool that uses some test timing data and generates a set of
graphs and extrapolation data. Just a simple python project that we want to run when we finish the tests to see how our
current builds perform in conjunction with older builds. Well we finally got the tool far enough along that we were
beginning to attach it to the pipeline proper. I started developing a makefile and Jenkinsfile that we would use to
run this dockerized report tool.

.. code-block:: make

    docker_name := ubuntu
    DOCKER_VER ?= 20.04
    docker_args := -v $(shell pwd):/app $(test -t 0 && echo "-it") \
        --rm -u $(id -u):$(id -g)
    DOCKER = docker run $(docker_args) $(docker_name):$(DOCKER_VER)
    SHELL = $(DOCKER) /bin/bash

    .PHONY: shell
    shell:
        $(SHELL)

This is the code I wrote, I didn't realize at the time that I was messing with some mystical make variable, I was just
trying to make a variable that I could use to spawn an interactive shell inside of my container. I had inadvertently
just told make to try and run everything through ``docker run -v (...) ubuntu:20.04 /bin/bash`` instead of ``/bin/sh``.

Sure enough, make will run with this, and the error you git will be incredibly cryptic. On first glance, this message
seems to suggest that the container is having issues, but it is in fact make doing what you told it to do that is
causing the issue.

.. code-block:: bash

   docker run -it --rm -v /home/jmoore/projects/app:/app ubuntu:20.04 \
       "cd /app && ./app"
   docker: Error response from daemon: failed to create shim: OCI \
       runtime create failed: container_linux.go:380: \
       starting container process caused: exec: "-c": executable file \
       not found in $PATH: unknown.
   make: *** [Makefile:28: reports] Error 127

The only way that I managed to figure out that it had to be the makefile, was that I took that exact same command and
ran it perfectly fine from ``zsh``. Andrew and I noticed that and we went to look at he makefile. ``SHELL`` was the only
variable that we could see causing the issue. Sure enough I renamed the variable and poof, everything is back to normal.
