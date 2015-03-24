FROM ubuntu:14.04

MAINTAINER macadmins

ENV APP_ROOT /home/docker/code
ENV MOSCARGO_REPO /munki

#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN perl -p -i.orig -e 's/archive.ubuntu.com/mirrors.aliyun.com\/ubuntu/' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y build-essential git
RUN apt-get install -y python python-dev python-setuptools
RUN apt-get install -y nginx supervisor
RUN easy_install pip

# install uwsgi now because it takes a little while
RUN pip install uwsgi flask-bootstrap flask-appconfig flask-wtf docker-py

# install nginx
RUN apt-get install -y software-properties-common python-software-properties curl
RUN apt-get update
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get install -y sqlite3

# # Get Moscargo app
# RUN curl -O https://raw.githubusercontent.com/arubdesu/Moscargo/master/moscargo.py

# install our code
ADD . ${APP_ROOT}/

# setup all the configfiles
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s ${APP_ROOT}/nginx-app.conf /etc/nginx/sites-enabled/
RUN ln -s ${APP_ROOT}/supervisor-app.conf /etc/supervisor/conf.d/

VOLUME /munki

EXPOSE 80
ENTRYPOINT ["/home/docker/code/start.sh"]
