FROM organizrtools/base-alpine
LABEL MAINTAINER="organizrTools,christronyxyocum"

# install packages
RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache \
	apache2-utils \
  curl \
	git \
	libressl2.7-libssl \
	logrotate \
	nano \
	nginx \
	openssl \
	php7 \
	php7-fileinfo \
	php7-fpm \
	php7-json \
	php7-mbstring \
	php7-openssl \
	php7-session \
	php7-simplexml \
	php7-xml \
	php7-xmlwriter \
  php7-curl \
	php7-ldap \
	php7-pdo_sqlite \
	php7-sqlite3 \
	php7-session \
	php7-zip \
	php7-xmlrpc \
	php7-ftp \
	php7-zlib && \
 echo "**** configure nginx ****" && \
 echo 'fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> \
	/etc/nginx/fastcgi_params && \
 rm -f /etc/nginx/conf.d/default.conf && \
 echo "**** fix logrotate ****" && \
 sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
