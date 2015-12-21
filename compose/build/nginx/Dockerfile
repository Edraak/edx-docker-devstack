FROM ubuntu:14.04
MAINTAINER Omar Al-Ithawi <i@omardo.com>

RUN apt-get -y update
RUN apt-get -y install nginx

ADD edxapp.conf /etc/nginx/sites-enabled/edxapp
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

WORKDIR /etc/nginx

CMD ["/usr/sbin/nginx"]
