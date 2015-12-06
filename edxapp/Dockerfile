FROM ubuntu:14.04

MAINTAINER Omar Al-Ithawi <i@omardo.com>

# The latest from edx/master that worked with me
ENV EDX_VERSION 7a858b6e09afd96e68939e4074825d1459144a2e

# Use: git references to speed up clone
ENV EDX_REPO https://github.com/edx/edx-platform.git

RUN mkdir -p /edx/app/edxapp/
WORKDIR /edx/app/edxapp/

RUN apt-get update -y
# TODO: Use apt-get cache to speedup install
RUN apt-get install software-properties-common git -y

RUN git clone $EDX_REPO
WORKDIR /edx/app/edxapp/edx-platform
RUN git checkout $EDX_VERSION

# TODO: Add this using the apt-repos.txt file
RUN apt-add-repository ppa:chris-lea/node.js
RUN apt-get update -y

# Allows ubuntu apt cache
# RUN rm /etc/apt/apt.conf.d/no-cache
ADD apt-packages.gitpatch /tmp/
RUN git apply /tmp/apt-packages.gitpatch
# TODO: Use apt-get cache to speedup install
RUN cat requirements/system/ubuntu/apt-packages.txt | xargs apt-get install -y

# TODO: Put on `apt-packages.txt` file
# TODO: Use apt-get cache to speedup install
RUN apt-get install python-pip -y

# TODO: Use both `pip` and `git` cahce to speed installs
RUN for pckg in pre base post paver development github local; \
      do pip install --exists-action w -r requirements/edx/$pckg.txt; \
    done


# TODO: Use apt-get cache to speedup install
RUN apt-get install ruby1.9.3 -y
RUN gem install bundler
RUN bundle install

# Fix hardcoded values
RUN mkdir -p /edx/app/edxapp/log \
    && mkdir -p /edx/var/edxapp/data \
    && mkdir -p /edx/app/edxapp/uploads


# TODO: Fix it in the actual code
# ADD logsettings.py openedx/core/lib/

# Keep those at last to have less cache invalidations

# Turn off a warning with Paver!
ADD env/*.json /edx/app/edxapp/

ADD lms_docker_env.py lms/envs/docker.py
ADD cms_docker_env.py cms/envs/docker.py

ADD docker_common.py lms/envs/
ADD docker_common.py cms/envs/

RUN paver install_prereqs

EXPOSE 8000 8001
