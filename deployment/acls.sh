#!/bin/bash

for i in /var/lib/tomcat9/{lib,webapps} /etc/tomcat9 /var/{log,cache}/tomcat9; do
  setfacl -R -m g:staff:rwX "$i" && find "$i" -type d | xargs setfacl -m d:g:staff:rwX
done
