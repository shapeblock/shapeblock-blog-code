FROM ubuntu:16.04

LABEL maintainer="Lakshmi Narasimhan <lakshmi@shapeblock.com>"

ENV UBUNTU_RELEASE=xenial \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    DEBIAN_FRONTEND=noninteractive \
    ACCEPT_EULA=y \
    HOME=/opt/app-root/src \
    S2I_SCRIPTS_PATH=/usr/libexec/s2i

LABEL io.k8s.description="Base image for Ubuntu based LEMP" \
      io.k8s.display-name="OpenShift LEMP" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder, Nginx, php-fpm, php-7.1"

RUN apt-get update && apt-get install -y nginx \
    && apt-get install -y locales \
    && locale-gen en_US.UTF-8 \
    && apt-get -y install software-properties-common python-software-properties \
    && add-apt-repository -y ppa:ondrej/php && apt-get update \
    && apt-get -y install php7.1 php7.1-fpm php7.1-cli php7.1-common php7.1-curl \
    php7.1-mbstring php7.1-soap php7.1-xml php7.1-zip php7.1-memcached php7.1-mysql \
    php7.1-gd php7.1-opcache php7.1-intl php7.1-pdo-sqlite \
    wget libfreetype6-dev libjpeg-dev libpng-dev mysql-client curl gettext unzip git \
    && apt-get -y remove --purge software-properties-common python-software-properties \
    && apt-get -y autoremove && apt-get -y autoclean && apt-get clean && rm -rf /var/lib/apt/lists /tmp/* /var/tmp/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./s2i/bin/ /usr/libexec/s2i

RUN mkdir -p /opt/app-root/etc/nginx && \
    chown -R 1001:0 /opt/app-root/etc/nginx

# code permissions

RUN useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin -c "Default Application User" default \
    && mkdir -p ${HOME} \
    && chown -R 1001:0 ${HOME} && chmod -R g+rwX ${HOME}


RUN chown -R 1001:0 /usr/share/nginx
RUN chown -R 1001:0 /var/log && chmod -R g+rwX /var/log
RUN chown -R 1001:0 /var/lib/nginx && chmod -R g+rwX /var/lib/nginx
RUN chown -R 1001:0 /var/run && chmod -R g+rwX /var/run
RUN chown -R 1001:0 /etc/nginx && chmod -R g+rwX /etc/nginx
RUN sed -i \
        -e "s/;listen.allowed_clients = 127.0.0.1/listen.allowed_clients = 127.0.0.1/g" \
	-e "s/listen = \/run\/php\/php7.1-fpm.sock/listen = 127.0.0.1:9000/g" \
	/etc/php/7.1/fpm/pool.d/www.conf
RUN echo "clear_env=false" >> /etc/php/7.1/fpm/pool.d/www.conf

RUN sed -i \
        -e "s/mysqli.default_socket =/mysqli.default_socket = \/var\/lib\/mysql\/mysql.sock/g" \
        -e "s/pdo_mysql.default_socket=/ pdo_mysql.default_socket=\/var\/lib\/mysql\/mysql.sock/g" \
        /etc/php/7.1/fpm/php.ini

COPY ./files/symfony-demo /etc/nginx/sites-enabled/default

WORKDIR ${HOME}

EXPOSE 8080

USER 1001

CMD ["/usr/libexec/s2i/usage"]
