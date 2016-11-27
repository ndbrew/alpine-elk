FROM openjdk:8u92-jre-alpine
MAINTAINER Nathan Brewer

# This layer as it will be re-used in the other ELK stack images
RUN apk add --no-cache bash su-exec

ARG LS_VERSION=5.0.0
ARG LS_HOME=/opt/logstash
ARG LS_USER=logstash
ARG LS_UID=998

# Install
RUN apk add --no-cache --virtual build_deps ca-certificates curl \
  && apk add --no-cache libzmq \
  && mkdir -p /usr/local/lib \
  && ln -s /usr/lib/*/libzmq.so.3 /usr/local/lib/libzmq.so \
  && mkdir -p /opt \
  && cd /tmp \
  && curl https://artifacts.elastic.co/downloads/logstash/logstash-$LS_VERSION.tar.gz > logstash-$LS_VERSION.tar.gz \
  && tar -xzf logstash-$LS_VERSION.tar.gz \
  && rm -rf logstash-$LS_VERSION.tar.gz \
  && mv logstash-$LS_VERSION $LS_HOME \
  && adduser -s /sbin/nologin -D -h $LS_HOME -H -u $LS_UID $LS_USER \
  && mkdir $LS_HOME/plugins \
  && mkdir $LS_HOME/logs \
  && chown $LS_USER:$LS_USER -R $LS_HOME/ \
  && apk del build_deps

ARG LS_PLUGINS=""

# Configure Default Settings
ARG LS_XMS=-Xms256m
ARG LS_XMX=-Xmx256m

ENV PATH=$LS_HOME/bin:$PATH \
  LS_SETTINGS_DIR=$LS_HOME/config
RUN sed -i "s/^-Xms.*/${LS_XMS}/" $LS_SETTINGS_DIR/jvm.options \
  && sed -i "s/^-Xmx.*/${LS_XMX}/" $LS_SETTINGS_DIR/jvm.options \
  && sed -i "/path.config:/c\path.config: $LS_HOME/conf.d" $LS_SETTINGS_DIR/logstash.yml

# Custom Settings
COPY config $LS_HOME/config/
COPY conf.d $LS_HOME/conf.d/
RUN chown $LS_USER:$LS_USER -R $LS_HOME/conf.d $LS_HOME/config

USER $LS_USER

# Install Plugins
RUN for plugin in $PLUGINS; do \
$LS_HOME/bin/logstash-plugin install $plugin; \
done

CMD ["logstash"]
