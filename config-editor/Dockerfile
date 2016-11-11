FROM alpine:3.4
MAINTAINER Nathan Brewer

ARG INSTALL_PKGS="vim git"
RUN apk add --no-cache curl ca-certificates ${INSTALL_PKGS}

ARG ES_UID=997
ARG ES_USER=elasticsearch
ARG LS_UID=996
ARG LS_USER=logstash
ARG KB_UID=995
ARG KB_USER=kibana
RUN adduser -s /bin/sh -D -H -u $KB_UID $KB_USER \
  && adduser -s /bin/sh -D -H -u $LS_UID $LS_USER \
  && adduser -s /bin/sh -D -H -u $ES_UID $ES_USER

CMD ["/bin/sh"]
