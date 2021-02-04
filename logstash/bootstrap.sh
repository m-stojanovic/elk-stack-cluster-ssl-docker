#!/bin/bash

for repodir in $( sudo egrep '^path.logs' /etc/logstash/logstash.yml | awk '{print $2}'); do
        sudo chown -R logstash:logstash $repodir &
done
for datadir in $( sudo egrep '^path.data' /etc/logstash/logstash.yml | awk '{print $2}'); do
        sudo chown -R logstash:logstash $datadir &
done

sudo chown -R logstash:logstash /etc/logstash

service logstash start

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
