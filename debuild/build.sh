#!/bin/bash

set -ex

INPUT_PATH="/pkg/incoming"
OUTPUT_PATH="/pkg/output"

PKG_PATH="/pkg/work"
GEN_PATH="/pkg/generated"
SRC_PATH="${PKG_PATH}/${PACKAGE_NAME}-${PACKAGE_VERSION}"

TARGET_UID=$(stat -c '%u' "${INPUT_PATH}")
TARGET_GID=$(stat -c '%g' "${INPUT_PATH}")

# Setup files
cp -a "$INPUT_PATH" "$PKG_PATH"

# Install dependencies
cd "$SRC_PATH"
apt-get update
mk-build-deps --install --tool "apt-get -qqy" debian/control
rm -f ${PACKAGE_NAME}-build-deps_${PACKAGE_VERSION}-*.deb

# Build
dpkg-buildpackage -us -uc

# Extract files
mkdir -p "$GEN_PATH"
grep '^Package:' debian/control | sed 's/Package: //' | while read pname; do cp ${PKG_PATH}/${pname}_${PACKAGE_VERSION}* "$GEN_PATH"; done

chown "${TARGET_UID}:${TARGET_GID}" ${GEN_PATH}/*
mv -v ${GEN_PATH}/* "$OUTPUT_PATH"
