#!/usr/bin/env bash
context_name=$1

docker context rm "${context_name}" || true
docker context create lima-docker --docker "host=unix://${HOME}.lima/docker/sock/docker.sock"
docker context use lima-docker
