# Contributing to Catalyst

We're building a crowd-sourcing platform to effect meaningful change in our communities. Obviously we're doing it with open-source software. We need your help!

If you'd like to contribute, please assign yourself to an Issue, create a branch, and then submit a pull request.

## TL;DR

Pull requests will need:

 - Tests
 - A logical series of [well written commits](https://github.com/alphagov/styleguides/blob/master/git.md)

## Development Environment

We're using Docker to assist in building reliable development environments (highly recommended, though it's not required). If you're using a Mac, you'll need a Docker VM and it is highly recommended that you install [Docker for Mac][docker-product-page] to serve this purpose. If you're using Windows, you may find the similar [Docker for Windows][docker-product-page] offering works well, but the author of this document does not have personal experience with it.

### Requirements

- [Docker][docker-product-page]
- [docker-compose][]
    - on OSX, `brew install docker-compose`
- ruby (only for the `bin/setup` script -- the app runs in Docker)
    - the default installation on OSX should work fine

### Getting Started Procedure

1. Fork <https://github.com/staywoke/catalyst> to your username.

2. Clone your forked repository locally:

    ```sh
    git clone git@github.com:yourusername/catalyst.git
    ```

3. Enter the local directory `cd catalyst`.

4. You must [configure a remote](https://help.github.com/articles/configuring-a-remote-for-a-fork/) for your fork so that you can [sync changes you make](https://help.github.com/articles/syncing-a-fork/) with the original repository.

    ```sh
    git remote add upstream git@github.com:staywoke/catalyst
    ```

5. Ensure you have installed Docker and that your shell is set up to connect to the Docker daemon (try running `docker info`); then run the automatic setup script:

    ```sh
    bin/setup
    ```

    This will validate you have the required depdencies, pull or build the necessary Docker images, set up the database, and start the app, before opening the running app in your browser. The script finishes (successfully) by running the following command:

    ```sh
    docker-compose logs -f app worker
    ```

    It's safe to `^C` to kill that -- the app and worker containers will stay up.

6. Subsequently, it is safe to run the `bin/setup` script any time you come back to the project.

[docker-product-page]: https://www.docker.com/products/docker
[docker-compose]: https://www.docker.com/products/docker-compose

### Running Tests

```sh
docker-compose run --rm app rake
```

If you want to benefit from Spring, run a bash shell in the Docker container, and run rake from there:

```plain
$ docker-compose run --rm app bash

[INFO  tini (1)] Spawned child process '/app/docker/entrypoint.sh' with pid '6'
[entrypoint.sh] exec bash
root@10bc79d42596:/app# rake
...
```

Keep that container running so the Spring master stays alive, then you can re-run `rake` which will start up faster.

### Other Docker-Related Things to Note

- You should familiarize yourself with Docker and docker-compose's core principles.

- The `bin/setup` script will symlink the example `docker-compose.override.example.yml` file to `docker-compose.override.yml` (as long as there isn't already a file there)

    - if you need to make changes to the override settings, _copy_ the example instead and then feel free to change your local copy of the (gitignored) `docker-compose.override.yml` file.

- The default configuration assumes you're running Docker with the ability to use Docker volumes to share your local tree into the container. If you're using a remote Docker VM, you'll have to figure out how to sync changes you make up to that VM's filesystem (or remove the `.:/app` volume mount defined in the `docker-compose.override.yml` file and then re-build the image after a change).

- If things get corrupted, sometimes it is helpful to start from scratch.

    ```sh
    docker-compose down -v
    ```

    This will kill and remove all docker containers and volumes.

    Note that this means your local Database will be deleted. (You could try running it without the `-v` option first which will save the DB volume from destruction.)
