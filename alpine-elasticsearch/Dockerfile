FROM openjdk:8u92-jre-alpine
MAINTAINER Nathan Brewer

# This layer as it will be re-used in the other ELK stack images
RUN apk add --no-cache bash

ARG ES_VERSION=5.0.0
ARG ES_HOME=/opt/elasticsearch
ARG ES_USER=elasticsearch
ARG ES_UID=998

# Install
RUN apk add --no-cache --virtual build_deps ca-certificates curl \
  && mkdir -p /opt \
  && cd /tmp \
  && curl https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ES_VERSION.tar.gz > elasticsearch-$ES_VERSION.tar.gz \
  && tar -xzf elasticsearch-$ES_VERSION.tar.gz \
  && rm -rf elasticsearch-$ES_VERSION.tar.gz \
  && mv elasticsearch-$ES_VERSION $ES_HOME \
  && adduser -s /sbin/nologin -D -h $ES_HOME -H -u $ES_UID $ES_USER \
  && mkdir -p $ES_HOME/plugins $ES_HOME/logs $ES_HOME/data \
  && chown $ES_USER:$ES_USER -R $ES_HOME/ \
  && apk del build_deps

ARG ES_PLUGINS=""

# Configure Default Settings
ARG ES_XMS=-Xms256m
ARG ES_XMX=-Xmx256m

ENV PATH=$ES_HOME/bin:$PATH \
  ES_SETTINGS_DIR=$ES_HOME/config
RUN sed -i "s/^-Xms.*/${ES_XMS}/" $ES_SETTINGS_DIR/jvm.options \
  && sed -i "s/^-Xmx.*/${ES_XMX}/" $ES_SETTINGS_DIR/jvm.options

# Custom Settings
COPY config $ES_HOME/config/
RUN chown $ES_USER:$ES_USER -R $ES_HOME/config

USER $ES_USER

# Install Plugins
RUN for plugin in $ES_PLUGINS; do \
$ES_HOME/bin/logstash-plugin install $plugin; \
done

CMD ["elasticsearch"]
