#!/bin/bash

# Running additional tasks if needed by the project 
if [ -e "/init/init.sh" ]; then
  /init/init.sh
fi

if [ -z "$1" ]; then
  sleep infinity
elif [ "$1" == "notebook" ]; then
  jupyter lab\
  --ip='0.0.0.0' \
  --port=${JUPYTER_PORT} \
  --NotebookApp.token='' \
  --NotebookApp.notebook_dir=""
else
  exec $1
fi