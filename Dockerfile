FROM pataquets/ubuntu:trusty

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get -y upgrade && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get -y install \
      apache2 \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/

# https://bugs.launchpad.net/ubuntu/+source/apache2/+bug/603211
RUN \
  mkdir -vp /var/run/apache2 && \
  mkdir -vp /var/lock/apache2

VOLUME [ "/var/log/apache2" ]

EXPOSE 80 443

# @todo: Add docker-init script and use 50-apache2-unset-home to:
# @todo: unset HOME as done in /etc/apache2/envvars
ENV APACHE_RUN_USER	www-data
ENV APACHE_RUN_GROUP	www-data
ENV APACHE_LOG_DIR	/var/log/apache2
ENV APACHE_LOCK_DIR	/var/lock/apache2
ENV APACHE_RUN_DIR	/var/run
ENV APACHE_PID_FILE	/var/run/apache2.pid

WORKDIR /var/www/html
CMD [ "apache2", "-D", "FOREGROUND", "-c", "ErrorLog /dev/stdout", "-c", "LogLevel warn" ]
