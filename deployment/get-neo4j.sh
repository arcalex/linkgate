#!/bin/sh
set -e

if [ $# -ne 2 ]; then
  echo "Usage: $0 <neo4j_version> <apoc_version>" >&2
  exit 1
fi

bn="neo4j-community-$1"  # basename

echo "Downloading Neo4j..." >&2

# Without -O, filename has  "artifact.php?..."
wget "https://neo4j.com/artifact.php?name=neo4j-community-$1-unix.tar.gz" -O "$bn-unix.tar.gz"

if [ -e "$bn" ]; then
  echo "'$bn' already exists!" >&2
  exit 1
fi

mkdir -p "$bn/plugins"
cd "$bn/plugins"

echo "Downloading APOC..." >&2

wget "https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/$2/apoc-$2-all.jar"

if [ -e "$bn-unix-with-apoc.tar.gz" ]; then
  echo "'$bn-unix-with-apoc.tar.gz' already exists!" >&2
  exit 1
fi

cd ../..

echo "Packing APOC into Neo4j's tgz..." >&2

zcat "$bn-unix.tar.gz" > "$bn-unix-with-apoc.tar"
tar -rf "$bn-unix-with-apoc.tar" "$bn"
gzip "$bn-unix-with-apoc.tar"

rm -r "$bn"
