FROM lakshminp/drupal-openshift-base:1.0

RUN git clone --depth=1 https://github.com/badri/drupal-8-composer.git /code
RUN cd /code && rm -rf .git && composer install
