#!/bin/bash

PROXY_SERVER=192.168.172.1
PROXY_PORT=1080

export http_proxy=http://$PROXY_SERVER:$PROXY_PORT
export https_proxy=$http_proxy




