# ISCAN SPADE server
This is Django server framework for the ISCAN web application used by the SPADE project.

## Prerequisites
ISCAN server uses [Docker](https://www.docker.com/what-docker). This containerization means that the only dependency the user must install is Docker itself.

### Preparing Docker
* Install [Docker for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce). It is easiest to install using the *Install from repository* method.
* Complete the [post-installation instructions](https://docs.docker.com/install/linux/linux-postinstall/) for Docker for Ubuntu. This will make it unnecessary to prepend Docker commands with `sudo`.
* Install [Docker Compose](https://docs.docker.com/compose/install/), the tool for defining and running multi-container Docker applications.

## Installation

First, clone the iscan-server repository to your machine:

``git clone https://github.com/MontrealCorpusTools/iscan-spade-server.git``

Included are a `Dockerfile` and a `docker-compose.yml`. In order to build a Docker image from these files, navigate to the root of the repository and run:

``docker-compose build``

Then, run:

``docker-compose up``

This will launch the containers.

### Development Installation

If you are intending to develop or make changes to ISCAN itself a few things must be done differently.

First, you must also clone the ISCAN repository in the same directory that you cloned your iscan-server directory.

``git clone https://github.com/MontrealCorpusTools/ISCAN.git``

So, you will have a directory containing the two repos, `ISCAN` and `iscan-spade-server`. Then, just `cd` into the `iscan-spade-server` directory.

To build the image, run the following command instead of just `docker-compose build`.

``docker-compose build --build-arg BUILD_ENV="dev"``

This will allow you to make changes in the ISCAN repo directory, and have them reflected in the docker installation.

### Initial migrations

The first time you use iscan-server, you will need to make database migrations. In another terminal, while the containers are up, run:

``docker-compose run app init``

The needed migrations to perform will be detected and made.

### Superuser creation
The first time you use iscan-server, you will need to set up a username and password to log in with. In another terminal, while the containers are up, run:

``docker-compose run app manage createsuperuser``

This will begin a prompt that asks you for a username, email address, and password. Once you have filled them out, the prompt will close.

Then, you should be able to log in with your credentials. You should only need to perform this step once; from now on, whenever you start the server, you should be able to log in with your defined username and password. When finished, press :code:`Ctrl+C` to end the current server run.

## Use and workflow

### Starting and stopping the server
To start the server and its containers using the Docker image, run:

``docker-compose up``

In your web browser, navigate to `localhost:8080`. You should see the I-SCAN web page.

To stop the server, press `Ctrl+C` only once. The terminal should show a `Gracefully stopping...` message and then exit.


### Tests

To run the automatic tests, run:

``./runtests.sh``


### Mounted volumes

This Docker instance is configured so that the contents of certain directories persist between runs of the server, and so that contents are constant between the local directory and the directory in the container. These local directories, located in the root of the repository, are:

* `polyglot_source/` - the directory containing corpora to be loaded.
* `polyglot_data/` - the directory where corpus metadata will be stored
* `pgdb/` - the directory where the front-end code is stored
* `polyglot_server/` - the directory containing the Django project for the server

Changes you make locally in these folders should persist into the container without needing to re-build the Docker image.

### Cleaning
The `docker-compose up` command usefully regenerates fresh containers each time it is run, but old containers can take up space. To clean up containers on your machine, first stop all of them:

```docker-compose stop```

Then, remove them:

``docker-compose rm``

