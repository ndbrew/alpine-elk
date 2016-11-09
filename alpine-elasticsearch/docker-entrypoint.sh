#!/bin/bash

set -e

# Drop root privileges if we are running elasticsearch
# allow the container to be started with `--user`
if [ "$1" = 'elasticsearch' ]; then
	#Initialize configuration if directory empty
        if [ ! "$(ls -A /volumes/elasticsearch)" ]; then
           cp -R /usr/local/share/elasticsearch/config /volumes/elasticsearch/config
           cd /volumes/elasticsearch
           mkdir data plugins logs
           cd /opt/elasticsearch
           ln -s /volumes/elasticsearch/config/ .
           ln -s /volumes/elasticsearch/data/ .
           ln -s /volumes/elasticsearch/plugins/ .
           ln -s /volumes/elasticsearch/logs/ .
        fi

        chown -R elasticsearch:elasticsearch /volumes/elasticsearch/

        if [ "$(id -u)" = '0' ]; then        
	  set -- su-exec elasticsearch sh -c elasticsearch $@
        else
	  set -- $@
        fi
fi

exec "$@"
