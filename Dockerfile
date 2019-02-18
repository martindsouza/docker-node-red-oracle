FROM nodered/node-red-docker:latest
LABEL MAINTAINER="Martin"

ENV \
  # The only environment variable that should be changed!
  LD_LIBRARY_PATH=/tmp/instantclient_18_3 \
  ORACLE_INSTANT_CLIENT_ZIP=instantclient-basiclite-linux.x64-18.3.0.0.0dbru.zip

COPY ./files/${ORACLE_INSTANT_CLIENT_ZIP} /tmp/

USER root
WORKDIR /tmp
RUN unzip ${ORACLE_INSTANT_CLIENT_ZIP} && \
  apt-get update && \
  apt-get install libaio1

USER node-red
WORKDIR /usr/src/node-red

