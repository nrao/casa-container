# syntax=docker/dockerfile:1
FROM rockylinux/rockylinux:9-ubi-init

ARG CASA_VERSION="6.7.5-18"

LABEL org.opencontainers.image.title="Common Astronomy Software Applications"
LABEL org.opencontainers.image.vendor="Associated Universities, Inc. Washington DC, USA"
LABEL org.opencontainers.image.url="https://casa.nrao.edu/"
LABEL org.opencontainers.image.documentation="https://casadocs.readthedocs.io/"
LABEL org.opencontainers.image.version="$CASA_VERSION"
LABEL org.opencontainers.image.licenses="BSD-3-Clause"
## https://specs.opencontainers.org/image-spec/annotations/
# org.opencontainers.image.source=""

RUN dnf install -y glibc-langpack-en && dnf clean all
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

RUN dnf update -y && \
    ## for extracting archive
    dnf install -y xz && \
    ## For running casa
    dnf install -y perl && \
    ## cleanup
    dnf clean all && \
    rm -rf /var/cache/dnf

## Casa tarball
COPY "files/casa-${CASA_VERSION}-py3.12.el9.tar.xz" /tmp/casa.tar.xz
RUN cd /opt && \
    tar -xf /tmp/casa.tar.xz && \
    rm -f /tmp/casa.tar.xz && \
    ln -s "/opt/casa-${CASA_VERSION}-py3.12.el9" /opt/casa

## Site config
COPY casasiteconfig.py /opt/
ENV CASASITECONFIG=/opt/casasiteconfig.py

VOLUME /measuredata
