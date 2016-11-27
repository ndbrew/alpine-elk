FROM alpine:3.4
MAINTAINER Nathan Brewer

ARG INSTALL_PKGS="vim git"
RUN apk add --no-cache su-exec curl ca-certificates ${INSTALL_PKGS}

CMD ["/bin/sh"]
