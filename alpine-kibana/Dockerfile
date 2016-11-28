FROM alpine:3.4
MAINTAINER Nathan Brewer

# This layer as it will be re-used in the other ELK stack images
RUN apk add --no-cache nodejs

ARG KB_VERSION=5.0.0-linux-x86_64
ARG KB_HOME=/opt/kibana
ARG KB_USER=kibana
ARG KB_UID=997

# Install logstash
RUN apk add --no-cache --virtual build_deps ca-certificates curl \
  && mkdir -p /opt \
  && cd /tmp \
  && curl https://artifacts.elastic.co/downloads/kibana/kibana-${KB_VERSION}.tar.gz > kibana-$KB_VERSION.tar.gz \
  && tar -xzf kibana-$KB_VERSION.tar.gz \
  && rm -rf kibana-$KB_VERSION.tar.gz \
  && mv kibana-$KB_VERSION $KB_HOME \
  && adduser -s /sbin/nologin -D -h $KB_HOME -H -u $KB_UID -g $KB_UID $KB_USER \
  && chown $KB_USER:$KB_USER -R $KB_HOME/ \
  && rm -rf $KB_HOME/config $KB_HOME/node \
  && mkdir -p $KB_HOME/node/bin \
  && ln -s $(which node) $KB_HOME/node/bin/ \
  && apk del build_deps

ARG PLUGINS=""

# Configure Kibana
ENV PATH=$KB_HOME/bin:$PATH \
  KB_SETTINGS_DIR=$KB_HOME/config
COPY config $KB_SETTINGS_DIR
RUN chown $KB_USER:$KB_USER -R $KB_SETTINGS_DIR

USER $KB_USER
# Install Plugins
RUN for plugin in $PLUGINS; do \
$KB_HOME/bin/kibana-plugin install $plugin; \
done

CMD ["kibana"]
