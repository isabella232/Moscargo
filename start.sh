#!/bin/bash

set -ex

echo $@

ln -s ${MOSCARGO_REPO}/icons /home/docker/code/moscargo/static/icons
ln -s ${MOSCARGO_REPO}/pkgs /home/docker/code/moscargo/static/pkgs
supervisord -n
