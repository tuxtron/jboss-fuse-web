#!/bin/bash

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/httpd/* /tmp/httpd*


echo "dec6dwbv-mobd1" >> /etc/hosts
echo "172.0.0.1 dec6dwbv-mobd1" >> /etc/hosts
exec /usr/sbin/apachectl -DFOREGROUND
