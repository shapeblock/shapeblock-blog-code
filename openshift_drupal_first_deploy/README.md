## Build Drupal image

### Base Drupal image

$ cd drupal-base-image

$ docker build -t lakshminp/drupal-openshift-base:1.0 .

$ docker push lakshminp/drupal-openshift-base:1.0

### Inject source code

$ cd drupal-container

Feel free to add your source code here. Change settings.php, assumption: docroot is /web.

$ docker build -t lakshminp/drupal-openshift:1.0 .

$ docker push lakshminp/drupal-openshift:1.0


## Build a basic Nginx image

$ cd nginx-container

$ docker build -t lakshminp/nginx-openshift:1.0 .

$ docker push lakshminp/nginx-openshift:1.0

## Inject images to OpenShift registry

$ oc import-image drupal-openshift:1.0 --from=lakshminp/drupal-openshift:1.0 --confirm
$ oc import-image openshift/nginx-openshift:1.0 --from=lakshminp/nginx-openshift:1.0 --confirm

$ oc tag drupal-openshift:1.0 drupal-openshift:latest

$ oc tag nginx-openshift:1.0 nginx-openshift:latest

## Deploy a MariaDB service

## Create other resources for Drupal
  * service
  * volume
  * volume claim
  * deployment

## Create and expose a route
