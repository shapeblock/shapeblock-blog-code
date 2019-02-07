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

$ oc import-image nginx-openshift:1.0 --from=lakshminp/nginx-openshift:1.0 --confirm

$ oc tag drupal-openshift:1.0 drupal-openshift:latest

$ oc tag nginx-openshift:1.0 nginx-openshift:latest

## Deploy a MariaDB service

$ oc apply -f db-secrets.yml

$ oc apply -f mariadb-dc.yml

$ oc apply -f mariadb-svc.yml

## Create other resources for Drupal

$ oc apply -f drupal-pvc.yml

$ oc apply -f drupal-dc.yml

$ oc apply -f drupal-svc.yml

## Create and expose a route

$ oc expose svc/drupal-8


## Make changes and trigger new deployments

### Change source code

$ composer require drupal/token
$ git commit -a -m "Add token module"
$ git push origin master


### Build new image

$ cd drupal-container

$ docker build -t lakshminp/drupal-openshift:1.1 .

$ docker push lakshminp/drupal-openshift:1.1

Import new image into our internal registry.

$ oc import-image drupal-openshift:1.1 --from=lakshminp/drupal-openshift:1.1 --confirm

Triggers a new deployment.

$ oc tag drupal-openshift:1.1 drupal-openshift:latest
