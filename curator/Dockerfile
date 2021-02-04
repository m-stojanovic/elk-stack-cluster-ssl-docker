FROM ubuntu:latest

ARG CURATOR_VERSION=5.8.3

# Install curator
RUN apt-get update && apt-get install -y sudo wget gnupg vim less cron && \
    wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - && \
    echo "deb [arch=amd64] https://packages.elastic.co/curator/5/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elastic.list && \
    apt-get update && apt-get install -y elasticsearch-curator=${CURATOR_VERSION}

# Prepare config files
COPY ./config /config

# Add cron jobs to crontab
RUN /usr/bin/crontab /config/crontab.txt

# Change permissions
RUN chown -R root:root /config
RUN chmod +x /config/cron/*

CMD ["/usr/sbin/crond","-f"]
