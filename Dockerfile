# https://github.com/bitnami/bitnami-docker-tomcat

FROM bitnami/tomcat:9.0-debian-10

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
  apt-get update; \
  apt-get -yq --no-install-recommends install \
    build-essential \
    ca-certificates \
    curl \
    wget \
    git \
    nano \
    vim \
    less \
    net-tools \
    apache2 \
    libapache2-mod-jk \
    libapache2-mod-rpaf \
  ; \
  apt-get clean; \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

# Files must be copied before "chmod -R a+rwx /opt/bitnami/tomcat"
# as server.xml is modified in place
COPY layer /

RUN echo 'web:x:10000:' >>/etc/group
RUN echo 'web:x:10000:10000:Web User:/home/user:/bin/bash' >>/etc/passwd

RUN set -eux; \
  a2enmod proxy proxy_ajp remoteip; \
  chmod -R a+rwx /opt/bitnami/tomcat; \
  install -d /a/shared/public -o 10000 -g 10000; \
  install -d /run/apache2 -o 10000; \
  chown -R 10000 /var/log/apache2;

USER 10000
ENV APACHE_RUN_USER="web"
ENV APACHE_RUN_GROUP="web"

ENV TOMCAT_AJP_PORT_NUMBER=8009
ENV TOMCAT_HTTP_PORT_NUMBER=8081
ENV TOMCAT_ALLOW_REMOTE_MANAGEMENT=1
ENV TOMCAT_USERNAME=user
ENV TOMCAT_PASSWORD=password

ENTRYPOINT [ "/entrypoint" ]