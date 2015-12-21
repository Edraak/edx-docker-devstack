#!/bin/bash

DIR=$1
BASENAME=`basename $DIR`

complain_about() {
  echo "Error"
  echo "You already have '$1' in your devstack."
  echo "Please commit and push if needed."
  echo "Then remove the '$1' so it can be re-created!"
  exit 1
}

if [ ! -e ${DIR} ]; then
  # If the directory is not there, create it.
  mkdir -p ${DIR}
elif [ ! -d ${DIR} ]; then
  # It's not a directory!
  complain_about ${BASENAME}
elif [ "$(ls -A ${DIR})" ]; then
  # If the directory is there and not empty complain about it.
  complain_about ${BASENAME}
fi # All ok
