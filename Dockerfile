FROM ubuntu:20.04 as builder-bluealza
# Dev deps
# RUN apt-get -qq  update
RUN apt-get update
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
                 && \
          ls
RUN cd bluez-alsa/build && make && make install

# COPY bluealsa.conf /etc/dbus-1/system.d/bluealsa.conf          
RUN apt-get -y install bluetooth
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install mopidy mopidy-alsamixer mopidy-local mopidy-mpd

# https://github.com/Arkq/bluez-alsa

# File that are changed by this build:
# ./bin/bluealsa-aplay
# ./bin/bluealsa
# ./bin/bluealsa-rfcomm
# ./bin/hcitop
# ./etc/dbus-1/system.d/bluealsa.conf
# ./etc/alsa/conf.d/20-bluealsa.conf



#  ----------- END blue-alsa build

# FROM ubuntu:20.04
# COPY --from=builder-bluealza '/usr/lib/x86_64-linux-gnu/alsa-lib' '/usr/lib/x86_64-linux-gnu/alsa-lib'
# COPY --from=builder-bluealza '/home/bluez-alsa/build-portable/bin' '/bin/'
# COPY --from=builder-bluealza '/home/bluez-alsa/build-portable/etc' '/etc/'


# copy
# /usr/lib/x86_64-linux-gnu/alsa-lib




# FROM python:3.7

# RUN apt-get update

# RUN apt-get install -y bluez bluetooth 


# Mopidy needs few things (that would be mounted with external volume):
# mopidy config
# local music

RUN apt install strace -y
RUN apt install mpc -y



#------ MODPIRY STUFF HERE
COPY mopidy /opt/mopidy
RUN mopidy --config=/opt/mopidy/configs/mopidy.conf local scan


COPY asound.conf /etc/asound.conf

WORKDIR /opt
COPY entrypoint.sh /opt/entrypoint.sh
    
CMD /bin/bash
ENTRYPOINT /bin/bash


