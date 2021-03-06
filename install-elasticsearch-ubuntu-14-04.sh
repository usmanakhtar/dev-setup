#!/usr/bin/env bash

# Installs, configures, and starts Elasticsearch.

set -e

# START OF SETTINGS SECTION
#

# Protobuf, Hadoop, etc., and data directories will go here:
#
# NOTE: directory is relative to home (~/), so "src" will be
#       referring to the directory "~/src"
SRC_BASE=src

# Default Java home -- if JAVA_VERSION is set below, then that
# particular JRE will be installed and JAVA_HOME will be overwritten:
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64

ELASTICSEARCH_VERSION=1.4.0

# END OF SETTINGS SECTION

# Does the source base directory exist? No? Well, create it!
cd ~
if [[ ! -d "$SRC_BASE" ]] ; then
    mkdir "$SRC_BASE"
fi
cd "$SRC_BASE"

sudo apt-get install -y wget

# Download and unpack Elasticsearch:
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz
tar xzf elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz
cd elasticsearch-${ELASTICSEARCH_VERSION}

# Install Marvel -- management/monitoring tool:
./bin/plugin -i elasticsearch/marvel/latest

# Start Elasticsearch:
echo ""
echo "!!! Firefox will open Marvel web-page in 30sec !!!"
echo ""
(sleep 30 ; firefox http://localhost:9200/_plugin/marvel) &
./bin/elasticsearch

