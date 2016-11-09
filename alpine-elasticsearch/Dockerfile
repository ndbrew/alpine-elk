FROM openjdk:8u92-jre-alpine

ENV ELASTICSEARCH_VERSION 5.0.0

# Install elasticsearch
RUN apk add --no-cache --virtual build_deps ca-certificates curl \
  && apk add --no-cache --virtual app_deps bash su-exec \
  && mkdir -p /opt \
  && cd /tmp \
  && curl https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz > elasticsearch-$ELASTICSEARCH_VERSION.tar.gz \
  && tar -xzf elasticsearch-$ELASTICSEARCH_VERSION.tar.gz \
  && rm -rf elasticsearch-$ELASTICSEARCH_VERSION.tar.gz \
  && mv elasticsearch-$ELASTICSEARCH_VERSION /opt/elasticsearch \
  && rm -rf /opt/elasticsearch/config \
  && mkdir -p /volumes/elasticsearch \
  && apk del build_deps

WORKDIR /opt/elasticsearch
RUN adduser -s /sbin/nologin -D -h /opt/elasticsearch -H elasticsearch

ENV PATH $PATH:/opt/elasticsearch/bin

COPY config /usr/local/share/elasticsearch/config
COPY docker-entrypoint.sh /

VOLUME /volumes/elasticsearch
EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
