#!/bin/bash

prepare_docker() {
    make deps
}

run_in_docker() {
    docker run --rm --privileged -w $PWD -v $PWD:$PWD -ti dib "$@"
}

prepare_docker
run_in_docker make
