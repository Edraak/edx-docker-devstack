#!/bin/bash
copy_content() {
  FROM=$1
  TO=$2

  cd $FROM
  find . -maxdepth 1 -mindepth 1 -exec cp -r {} $TO/{} \;
}

copy_content  \
    /edx/app/edxapp/edx-platform-buildcode  \
    /edx/app/edxapp/edx-platform


copy_content /edx/app/edxapp/buildenvs /edx/app/edxapp/devenvs
