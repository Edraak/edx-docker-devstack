FROM ubuntu:14.04

MAINTAINER Omar Al-Ithawi <i@omardo.com>

# The latest from edx/master that worked with me
# change it to the commit you'd like
ENV EDX_VERSION 99b029969c4d5fabb14a06361a39ee2f8d623598

ENV EDX_REPO https://github.com/edx/edx-platform.git

# Create directories that edX expects
RUN mkdir -p /edx/app/edxapp/log \
    && mkdir -p /edx/var/edxapp/data \
    && mkdir -p /edx/app/edxapp/uploads

WORKDIR /edx/app/edxapp/

RUN apt-get update -y  \
    && apt-get install -y  \
            git  \
            python-pip  \
            ruby1.9.3  \
            software-properties-common

RUN git clone $EDX_REPO edx-platform-buildcode  \
    && ln -sd edx-platform-buildcode edx-platform

WORKDIR /edx/app/edxapp/edx-platform
RUN git checkout $EDX_VERSION

RUN gem install bundler

# TODO: Add this using the apt-repos.txt file
# TODO: Add the repo without using `software-properties-common`
RUN apt-add-repository ppa:chris-lea/node.js
RUN apt-get update -y

# Allows ubuntu apt cache
# RUN rm /etc/apt/apt.conf.d/no-cache
ADD apt-packages.gitpatch /tmp/
RUN git apply /tmp/apt-packages.gitpatch  \
    && xargs apt-get install -y < requirements/system/ubuntu/apt-packages.txt

# Keep `pre.txt` in its own step to support options in base and other stuff
ENV REQUIREMENT_FILES 'github local base post paver'
RUN pip install --exists-action w -r requirements/edx/pre.txt  \
    && echo $REQUIREMENT_FILES | sed 's/ /\n/g' | xargs -L1 -I{}  \
          pip install -q  \
                      --disable-pip-version-check   \
                      --exists-action w -r requirements/edx/{}.txt  \
    && bundle install


COPY envs /edx/app/edxapp/buildenvs
RUN cd /edx/app/edxapp/  \
    && bash -c 'ln -s buildenvs/{lms,cms}.{env,auth}.json .'  \
    && bash -c 'cd edx-platform && paver install_prereqs'  \
    && bash -c 'rm {lms,cms}.{env,auth}.json'  \
    && bash -c 'ln -s devenvs/{lms,cms}.{env,auth}.json .'  \
    && rm edx-platform  \
    && ln -sd edx-platform-devcode edx-platform
