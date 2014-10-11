#!/bin/bash

TARGET=$1
DOCKER=/usr/bin/docker
USER=xelnet

function build_image() {
    local image default_tag full_tag dockerfile_path timestamp;
    image=$1;
    image_alias=$(basename "${image}");
    dockerfile_path="${image}/Dockerfile";
    #timestamp=$(date --utc --iso-8601=seconds | tr 'T' '_' | tr -d ':' | head -c -6);
    full_tag="${USER}/${image_alias}";  #:${timestamp}";

    if [[ -f "${image}/Makefile" ]]; then
        echo "Preparing build of ${image}..."
        make -C "${image}" || die 2 "make -C ${image} failed."
    fi

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
