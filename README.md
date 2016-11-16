# docker-vaultcli

A docker image based on openjdk:8 that contains python, vault, and a CLI for accessing vault secrets.

Use as a base image for java projects that want to fetch vault secrets at runtime.
A `VAULT_TOKEN` with appropriate credentials must be specified in the environment for secrets to be fetched.

Can be accessed from Dockerhub with:
```shell
$ docker pull broadinstitute/docker-vaultcli:latest
```