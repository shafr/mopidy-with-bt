FROM python:3.7

RUN apt-get update

RUN apt-get install -y bluez bluetooth 
