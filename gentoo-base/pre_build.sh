#!/bin/bash

function die() {
    echo "$1" >&2
    exit 1;
}

function announce() {
    local msg;
    msg="$1";
    echo -e "\n\n==== ${msg} ====\n";
}

TAG="20141009"
TARFILE="stage3-amd64-hardened-${TAG}.tar.bz2"
MIRROR="http://distfiles.gentoo.org/releases/amd64/autobuilds/${TAG}/hardened/"

cd $(dirname $0)

announce "Downloading files"
wget --continue "${MIRROR}/${TARFILE}"
wget --continue "${MIRROR}/${TARFILE}.CONTENTS"
wget --continue "${MIRROR}/${TARFILE}.DIGESTS"
wget --continue "${MIRROR}/${TARFILE}.DIGESTS.asc"

announce "Checking PGP signature"
gpg --verify "${TARFILE}.DIGESTS.asc" || die "Invalid gpg signature"

announce "Checking sha512sum checksum"
head -n 2 "${TARFILE}.DIGESTS" | sha512sum --check || die "Invalid sha512sum checksum"
