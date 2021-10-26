FROM python:3.8-slim as builder-bluealza
# Dev deps
RUN apt-get update
RUN apt -y install git autoconf libtool gcc binutils pkg-config

# Bluetooth-alza dependency -> BlueZ install
# ---------- BLUEZ
# build deps:
RUN apt -y install \
    bluetooth bluez libasound2 libglib2.0-dev sbc-tools \
    libmp3lame-dev libmpg123-dev libfdk-aac-dev \
    libdbus-1-dev \
    libreadline6-dev \
    libbsd-dev libncurses-dev

# openaptx 
# libopenaptx
# libldac 
# docutils

# ---------- BLUE-ALSA

RUN git clone https://github.com/Arkq/bluez-alsa.git --branch "master" --depth=1 
RUN cd bluez-alsa
RUN autoreconf --install
RUN mkdir build && cd build
RUN ../configure --enable-aac \
                 --enable-ofono \
                 --enable-debug \
                 --enable-mp3lame \
                 --enable-aac \
                 --enable-rfcomm \
                 --enable-hcitop



# FROM python:3.7

# RUN apt-get update

# RUN apt-get install -y bluez bluetooth 
