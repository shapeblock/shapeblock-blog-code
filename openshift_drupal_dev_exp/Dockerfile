FROM lakshminp/drupal-openshift-base:1.0

# COPY --chown=1001:0 . /code/
# Above command won't work on older docker versions.
# We do a chown as root and step down as non-root user.
COPY . /code/
USER root
RUN chown -R 1001:0 /code
USER 1001
# Cleanup git related stuff and run composer.
RUN cd /code && rm -rf .git && composer install
