#!/bin/bash -e

## Setup build files and perform docker build for casa monolith

CASA_VERSION="6.7.5-18"
PYTHON_VERSION="3.12"

ARCHIVE_URL_BASE="https://casa.nrao.edu/download/distro/casa/release/rhel"
# ARCHIVE_URL_BASE_PRERELEASE="https://casa.nrao.edu/download/distro/casa/releaseprep"

ARCHIVE_FILE="casa-${CASA_VERSION}-py${PYTHON_VERSION}.el9.tar.xz"
ARCHIVE_URL="${ARCHIVE_URL_BASE}/${ARCHIVE_FILE}"

mkdir -p files
pushd files
    if [[ ! -f "$ARCHIVE_FILE" ]]
    then
        curl -L -O $ARCHIVE_URL
    fi
popd

# docker build --pull -t nrao/casa:dev-latest --build-arg CASA_VERSION .
