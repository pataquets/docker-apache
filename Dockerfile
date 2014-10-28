FROM pataquets/ubuntu:precise

RUN DEBIAN_FRONTEND=noninteractive \
	apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install \
		apache2 \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/

# https://bugs.launchpad.net/ubuntu/+source/apache2/+bug/603211
RUN mkdir -p /var/run/apache2

VOLUME [ "/var/log/apache2" ]

EXPOSE 80 443

ENV APACHE_RUN_USER	www-data
ENV APACHE_RUN_GROUP	www-data
ENV APACHE_LOG_DIR	/var/log/apache2/
ENV APACHE_RUN_DIR	/var/run

CMD [ "apache2", "-D", "FOREGROUND", "-c", "ErrorLog |more", "-c", "LogLevel warn" ]
