#!/bin/bash
chown -R elasticsearch:elasticsearch /var/log/elasticsearch &
chown -R elasticsearch:elasticsearch /usr/share/elasticsearch &
chown -R elasticsearch:elasticsearch /etc/elasticsearch &

for repodir in $( sudo egrep '^path.repo' /etc/elasticsearch/elasticsearch.yml | awk '{print $2}'); do
	sudo chown -R elasticsearch:elasticsearch $repodir &
done
for datadir in $( sudo egrep '^path.data' /etc/elasticsearch/elasticsearch.yml | awk '{print $2}'); do
  	sudo chown -R elasticsearch:elasticsearch $datadir &
done
for logdir in $( sudo egrep '^path.logs' /etc/elasticsearch/elasticsearch.yml | awk '{print $2}'); do
  	sudo chown -R elasticsearch:elasticsearch $logdir &
done

service elasticsearch start

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
