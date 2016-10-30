# Contributing to Catalyst

We're building a crowd-sourcing platform to effect meaningful change in our communities. Obviously we're doing it with open-source software. We need your help!

If you'd like to contribute, please assign yourself to an Issue, create a branch, and then submit a pull request.

## TL;DR

Pull requests will need:

 - Tests
 - A logical series of [well written commits](https://github.com/alphagov/styleguides/blob/master/git.md)

## Development environment

We're using Docker to assist in building reliable development environments (highly recommended, though it's not required). If you're using a Mac, you'll need a Docker VM and it is highly recommended that you install [Docker for Mac][docker-product-page] to serve this purpose. If you're using Windows, you may find the similar [Docker for Windows][docker-product-page] offering works well, but the author of this document does not have personal experience with it.

### Requirements

- [Docker][docker-product-page]
- [docker-compose][]
    - on OSX, `brew install docker-compose`
- ruby (only for the `bin/setup` script -- the app runs in Docker)
    - the default installation on OSX should work fine

### Getting Started procedure

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

    This will validate you have the required depdencies, pull or build the necessary Docker images, set up the database, and start the app, before opening the running app in your browser.

    Subsequently, it is safe to run that script any time you come back to the project.

[docker-product-page]: https://www.docker.com/products/docker
[docker-compose]: https://www.docker.com/products/docker-compose

##
## Running Tests

```sh
docker-compose
```
