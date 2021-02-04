FROM ubuntu:latest

# Logstash version to install
ENV LS_VERSION 7.9.0

# Set the timezone
ENV TZ=Europe/Belgrade
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Get unused UID/GID to avoid possible user/group mess
ENV LS_UID 1099
ENV LS_GID 1099

# Disable IPv6
RUN \
  echo 'net.ipv6.conf.default.disable_ipv6 = 1' > /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.d/20-ipv6-disable.conf; \
  cat /etc/sysctl.d/20-ipv6-disable.conf; \
  sysctl -p;

# Install prerequisites
RUN \
    apt-get update && apt-get upgrade -y && apt-get install -y sudo wget apt-transport-https curl gnupg logrotate rsyslog vim less net-tools openjdk-11-jdk postgresql && \
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - && \
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list && \
    apt-get update && apt-get install -y logstash

# Install plugins
#COPY plugins/logstash-filter-math-1.1.1.gem /etc/logstash/plugins/
RUN /usr/share/logstash/bin/logstash-plugin install logstash-filter-translate && \
    /usr/share/logstash/bin/logstash-plugin install logstash-input-lumberjack
#   /usr/share/logstash/bin/logstash-plugin install /etc/logstash/plugins/logstash-filter-math-1.1.1.gem && \

# Cleanup
RUN apt-get clean all && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Prepare SSL Certificates
COPY ./ssl /etc/logstash/ssl

# Bootstrap
ADD bootstrap.sh /etc/bootstrap.sh

# Permissions
RUN chown root:root /etc/bootstrap.sh && \
    chown logstash:logstash /etc/logstash/ssl && \
    chmod 700 /etc/bootstrap.sh

CMD ["/etc/bootstrap.sh", "-d"]

EXPOSE 5043
EXPOSE 5044
EXPOSE 5045
EXPOSE 5046
