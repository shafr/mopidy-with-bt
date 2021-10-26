FROM ubuntu:20.04 as builder-bluealza
# Dev deps
RUN apt-get -qq  update
RUN apt-get -qq -y install --no-install-recommends \ 
    git autoconf libtool gcc binutils pkg-config \
    automake make build-essential

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

RUN git config --global http.sslverify false && \
    export GIT_SSL_NO_VERIFY=true && \
    git clone https://github.com/Arkq/bluez-alsa.git --branch "master" --depth=1

RUN cd bluez-alsa && \
    pwd && \
    autoreconf --install && \
    mkdir build && \
    mkdir build-postrable && \
    cd build && \
    ../configure --enable-aac \
                 --enable-ofono \
                 --enable-debug \ 
                 --enable-mp3lame \
                 --enable-aac \
                 --enable-rfcomm \
                 --enable-hcitop \
                 --disable-dependency-tracking \
                 --prefix=/home/bluez-alsa/build-portable && \
          \
          make && make install


# copy
# /usr/lib/x86_64-linux-gnu/alsa-lib




# FROM python:3.7

# RUN apt-get update

# RUN apt-get install -y bluez bluetooth 
