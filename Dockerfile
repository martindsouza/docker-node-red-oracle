FROM nodered/node-red-docker:latest
LABEL MAINTAINER="Martin"

ENV \
  # The only environment variable that should be changed!
  LD_LIBRARY_PATH=/tmp/oracle-instantclient \
  ORACLE_INSTANT_CLIENT_ZIP_URL="https://download.oracle.com/otn_software/linux/instantclient/193000/instantclient-basiclite-linux.x64-19.3.0.0.0dbru.zip"

USER root
WORKDIR /tmp

RUN echo "START" && \
  wget -q "$ORACLE_INSTANT_CLIENT_ZIP_URL"  && \
  mkdir $LD_LIBRARY_PATH && \
  unzip instantclient*.zip -d "$LD_LIBRARY_PATH" && \
  rm -rf instantclient*.zip && \
  # Rename and move
  mv $LD_LIBRARY_PATH/instant*/* $LD_LIBRARY_PATH && \
  apt-get update && \
  apt-get install libaio1 && \
  echo "END"

USER node-red
WORKDIR /usr/src/node-red

