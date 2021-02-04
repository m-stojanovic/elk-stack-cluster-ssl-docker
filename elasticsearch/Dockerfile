FROM ubuntu:latest

ENV ES_VERSION 7.9.0

# Get unused UID/GID to avoid possible user/group mess
ENV ES_UID 1100
ENV ES_GID 1100

# Disable IPv6
RUN \ 
  echo 'net.ipv6.conf.default.disable_ipv6 = 1' > /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  sysctl -p;

# Upragede system packages
RUN apt-get update && apt-get upgrade -y

# Install prerequisites
RUN \ 
  apt-get install -y sudo wget curl apt-transport-https gnupg unzip vim less net-tools openjdk-11-jdk && \
  wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - && \
  echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list 

# Add user:group (elasticsearch:elasticsearch) with preset uid:guid ($ES_UID:$ES_GID)
RUN \
  addgroup --quiet \
	   --gid ${ES_GID} \
	   elasticsearch && \
  useradd  --uid ${ES_UID} \
	   --gid elasticsearch \
	   elasticsearch

# Install elasticsearch
RUN apt-get update && apt-get install -y elasticsearch=${ES_VERSION}

# Cleanup
RUN apt-get clean all && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Prepare SSL Certificates
COPY ./ssl /etc/elasticsearch/ssl

# Prepare directory structure
RUN sudo mkdir -p /DATA0 /DATA1 /DATA2 

RUN sudo mkdir -p /etc/elasticsearch/scripts && \
    sudo mkdir -p /DATA0/elasticsearch /DATA0/elasticsearch/logs && \
    sudo mkdir -p /DATA1/elasticsearch /DATA1/elasticsearch/logs && \
    sudo mkdir -p /DATA2/elasticsearch /DATA2/elasticsearch/logs && \
    sudo mkdir -p /DATA0/elasticsearch/snapshots && \
    sudo mkdir -p /DATA1/elasticsearch/snapshots && \
    sudo mkdir -p /DATA2/elasticsearch/snapshots 

# Bootstrap
ADD bootstrap.sh /etc/bootstrap.sh

# Permissions
RUN chown root:root /etc/bootstrap.sh && chmod 700 /etc/bootstrap.sh && \
    chown -R elasticsearch:elasticsearch /etc/elasticsearch/ssl

CMD ["/etc/bootstrap.sh", "-d"]

EXPOSE 9200
EXPOSE 9300
