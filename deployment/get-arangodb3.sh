#!/bin/sh
set -e

# Download page: https://www.arangodb.com/download-major/ubuntu/

if [ $# -ne 1 ]; then
  echo "Usage: $0 <arangodb3_version>" >&2
  exit 1
fi

parentdir="arangodb3$(echo "$1" | cut -d. -f2)"

echo "Downloading ArangoDB..." >&2

# Use arangodb3-client-linux for client tools
wget "https://download.arangodb.com/$parentdir/Community/Linux/arangodb3-linux-$1.tar.gz"

