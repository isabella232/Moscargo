#!/bin/bash

set -ex

echo $@

ln -s /munki/icons /home/docker/code/moscargo/static/icons
supervisord -n
