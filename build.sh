#!/bin/bash

TARGET=$1
DOCKER=/usr/bin/docker
USER=xelnor

function build_image() {
    local image default_tag full_tag dockerfile_path;
    image=$1;
    default_tag=$(basename "${image}");
    dockerfile_path="${image}/Dockerfile";
    full_tag="${USER}/${default_tag}";

    if [[ ! -f "${dockerfile_path}" ]]; then
        die 1 "Missing Dockerfile at ${dockerfile_path}, exiting.";
    fi



    echo "Building image ${full_tag} from Dockerfile ${dockerfile_path}...";
    ${DOCKER} build -t "${full_tag}" "${image}"
}

function die() {
    local retcode msg;
    retcode=$1;
    msg=${2:-"Unknown error, aborting."};

    if [[ -t 2 ]]; then
        # stderr is a tty
        msg="\e[1;31m${msg}\e[0m";
    fi

    echo -e "${msg}" >&2;
    exit ${retcode};
}

function usage() {
    echo <<EOF
Usage: $0 path/to/imagedir

Build a docker image name ${USER}/imagedir from the Dockerfile at path/to/imagedir/Dockerfile.
EOF
}

if [[ -z "${TARGET}" ]]; then
    usage;
    exit 0;
fi

build_image "${TARGET}"