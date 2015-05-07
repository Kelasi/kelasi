Kelasi [![Build Status](https://travis-ci.org/Kelasi/kelasi.png?branch=master)](https://travis-ci.org/Kelasi/kelasi)
------

This repository holds the source code of the class advertisement system, Kelasi.


## How to run this application

We use [docker](https://www.docker.com) to setup our development environment.
Install `docker` and `docker-compose` and optionally `docker-machine`.

If you don't want to use *docker-machine* you can ignore the first three step and start from step 4.

1- Using `docker-machine` create an isolated environment for your docker boxes:

    docker-machine create --driver=virtualbox kelasi-backend  # You will need VirtualBox installed

2- Start the virtual machine:

    docker-machine start kelasi-backend

3- Setup Environment variables so that docker picks up the virtual machine:

    eval "$(docker-machine env kelasi-backend)"

4- To start the rails server:

    docker-compose up

Wait a moment. Now the rails server is running on port 3000.
If you didn't use the *docker-machine*, point your browser to `127.0.0.1:3000`.
Otherwise, use `docker-machine ip kelasi-backend` to get the ip of virtual machine and use it instead.

4.1- To start a rails console, run:

    docker-compose run web rails console

That's it!
