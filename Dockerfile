FROM ubuntu:20.04
# as builder-bluealza
# Dev deps
RUN apt-get -qq  update
RUN apt-get -qq -y install --no-install-recommends \ 
    git autoconf libtool gcc binutils pkg-config \
    automake

# Bluetooth-alza dependency -> BlueZ install
# ---------- BLUEZ
# build deps:


# RUN apt install --yes --quiet --no-install-recommends \
#     bluetooth bluez libasound2 libglib2.0-dev sbc-tools \
#     libmp3lame-dev libmpg123-dev libfdk-aac-dev \
#     libdbus-1-dev \
#     libreadline6-dev \
#     libbsd-dev libncurses-dev


RUN apt-get -qq -y install --no-install-recommends \
          check \
          libasound2-dev \
          libbluetooth-dev \
          libbsd-dev \
          libdbus-1-dev \
          libfdk-aac-dev \
          libglib2.0-dev \
          libmp3lame-dev \
          libmpg123-dev \
          libncurses5-dev \
          libreadline-dev \
          libsbc-dev \
          python-docutils

# openaptx 
# libopenaptx
# libldac 
# docutils

# ---------- BLUE-ALSA

RUN git config --global http.sslverify false && \
    export GIT_SSL_NO_VERIFY=true && \
    git clone https://github.com/Arkq/bluez-alsa.git --branch "master" --depth=1

RUN cd bluez-alsa && \
    ls -la && \
    autoreconf --install && \
    mkdir build && cd build && \
    ../configure --enable-aac \
                 --enable-ofono \
                 --enable-debug \ 
                 --enable-mp3lame \
                 --enable-aac \
                 --enable-rfcomm \
                 --enable-hcitop \
                 --disable-dependency-tracking && \
          \
          make && make install



# FROM python:3.7

# RUN apt-get update

# RUN apt-get install -y bluez bluetooth 
