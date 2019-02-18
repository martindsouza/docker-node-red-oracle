# Node Red Docker image with Oracle NodeJS Drivers

This docker image starts with the base [Node-RED](https://github.com/node-red/node-red-docker) Docker image and adds [node-oracledb](https://github.com/oracle/node-oracledb) so you can use the [Node-RED Oracle Database Node](https://github.com/martindsouza/node-red-contrib-oracledb) extension.

## Prerequisites

[Download](https://www.oracle.com/technetwork/database/database-technologies/instant-client/downloads/index.html) Oracle Instant Client Linux x86-64 - _Basic Lite Zip_
([specific link](https://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html)). We'll assume this file is in `~/Downloads/instantclient-basiclite-linux.x64-18.3.0.0.0dbru.zip`

Create a location to store the Node RED configuration files:

```
cd ~/docker
mkdir node-red
```


### _Optional_: Create Docker Network

I use the Docker Network `oracle_network` to put all my Oracle Containers on. If you do not have a network then run:

```bash
docker network create oracle_network
```

## Build Image

```bash
# Go to a directory to store this repo
# Ex: cd ~/Documents/Github/martindsouza
git clone https://github.com/martindsouza/docker-node-red-oracle.git
cd docker-node-red-oracle

# Copy downloaded Instant Client
cp ~/Downloads/instantclient-basiclite-linux.x64-18.3.0.0.0dbru.zip files/

# Build image
docker build -t node-red-oracle .
```

## Create Container

_Note: If you do not have the oracle_network setup then remove that line_

```bash
docker run -it -d \
  -p 1880:1880 \
  -v ~/docker/node-red:/data \
  --name nodered \
  --network=oracle_network \
  node-red-oracle
```

You can now access Node RED via http://localhost:1880/
