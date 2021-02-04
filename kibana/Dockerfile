FROM ubuntu:latest

# Kibana version
ENV KIBANA_VERSION 7.9.0

# Get unused UID/GID to avoid possible user/group mess
ENV KIBANA_UID 1101
ENV KIBANA_GID 1101

# Disable IPv6
RUN \
  echo 'net.ipv6.conf.default.disable_ipv6 = 1' > /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  cat /etc/sysctl.d/20-ipv6-disable.conf; \
  sysctl -p;

# Install prerequisites
RUN \
    apt-get update && apt-get upgrade -y && apt-get install -y wget curl apt-transport-https gnupg less vim net-tools && \
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list && \
    apt-get update

# Add user:group (kibana:kibana) with preset uid:gid ($KIBANA_UID:$KIBANA_GID)
RUN \
  addgroup --quiet \
           --gid ${KIBANA_GID} \ 
           kibana && \
  useradd  --uid ${KIBANA_UID} \
           --gid kibana \
           kibana 
 
 # Install kibana
 RUN \
   apt-get install kibana=${KIBANA_VERSION} && \
   update-rc.d kibana defaults 95 10
   
# Increase heap size
RUN awk 'NR==1{print; print "NODE_OPTIONS=\"--max-old-space-size=2560\""} NR!=1' /usr/share/kibana/bin/kibana > /usr/share/kibana/bin/kibana.tmp && \
    mv /usr/share/kibana/bin/kibana.tmp /usr/share/kibana/bin/kibana && \
    chmod a+x /usr/share/kibana/bin/kibana

# Cleanup
RUN apt-get clean all && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Prepare SSL Certificates
COPY ./ssl /etc/kibana/ssl

# Bootstrap
ADD bootstrap.sh /etc/bootstrap.sh

# Permissions
RUN chown root:root /etc/bootstrap.sh && chmod 700 /etc/bootstrap.sh && \
    chown -R kibana:kibana /etc/kibana/ssl

CMD ["/etc/bootstrap.sh", "-d"]

EXPOSE 5601
