FROM nginx:1.15

RUN useradd -u 1001 -r -g 0 -d /app -s /sbin/nologin -c "Default Application User" default \
    && mkdir -p /app \
    && chown -R 1001:0 /app && chmod -R g+rwX /app

COPY nginx.conf /etc/nginx
COPY drupal.conf /etc/nginx/conf.d/default.conf

RUN chown -R 1001:0 /var/log && chmod -R g+rwX /var/log
RUN chown -R 1001:0 /var/cache/nginx && chmod -R g+rwX /var/cache/nginx
RUN chown -R 1001:0 /var/run && chmod -R g+rwX /var/run
RUN chown -R 1001:0 /etc/nginx && chmod -R g+rwX /etc/nginx

EXPOSE 8080

USER 1001
