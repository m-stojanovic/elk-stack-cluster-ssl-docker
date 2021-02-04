#!/bin/bash
chown -R kibana:kibana /var/log/kibana
chown -R kibana:kibana /usr/share/kibana
chown -R kibana:kibana /etc/kibana

service kibana start

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
