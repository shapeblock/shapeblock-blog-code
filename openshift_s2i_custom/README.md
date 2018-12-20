## Custom centos based PHP s2i

### Building the image

```
$ docker build -t php-s2i-centos .
```

### Testing the image

```
$ s2i build test/test-app php-s2i-centos test-php-s2i-centos
```

```
$ docker run -d -p 8080:8080 test-php-s2i-centos
```

### Import the image into OpenShift cluster


```
$ oc import-image lakshminp/php-s2i-centos --confirm
```


### Create a new app

```
$ oc new-app php-s2i-centos~https://github.com/sclorg/cakephp-ex.git -e CAKEPHP_SECRET_TOKEN=94A22HZy6QNDlIjsjgJklc7vB2W0qRujPwbH2RS4 -e CAKEPHP_SECURITY_SALT=kGluK3k5OfuE6CUSDjmnsBpNvfv1OwSMWx4t9u9N --name=cakephp-app-1
```

### Confirm logs

```
$ oc logs -f bc/cakephp-app-1
Cloning "https://github.com/sclorg/cakephp-ex.git" ...
	Commit:	c1b7cdc5ff9bc1f04ef3a3bda896d9b1456e0204 (Merge pull request #107 from liangxia/url)
	Author:	Honza Horak <hhorak@redhat.com>
	Date:	Mon Oct 15 10:09:08 2018 +0200
Using lakshminp/php-s2i-centos@sha256:27ac622026511e79847f7b99f80fbbe315ee43affd16316815f2b469ec427fdb as the s2i builder image
---> Assemble script: starting...
---> Installing application source...
```

## Build a new mysql app


```
$ oc new-app mysql --name=app-db -l stack=lamp  -e MYSQL_USER=dbuser -e MYSQL_PASSWORD=iD7j2H2yBsxQV1 -e MYSQL_DATABASE=lampdb
$ oc expose svc/app-db
```
## Build a new PHP app from s2i

```
$ oc new-app php~https://github.com/sclorg/cakephp-ex.git -e DATABASE_SERVICE_NAME=app-db -e DATABASE_ENGINE=mysql -e DATABASE_NAME=lampdb -e DATABASE_USER=dbuser -e DATABASE_PASSWORD=iD7j2H2yBsxQV1 -e CAKEPHP_SECRET_TOKEN=94A22HZy6QNDlIjsjgJklc7vB2W0qRujPwbH2RS4 -e CAKEPHP_SECURITY_SALT=kGluK3k5OfuE6CUSDjmnsBpNvfv1OwSMWx4t9u9N --name=cakephp-app -l stack=lamp
--> Found image c88245e (6 weeks old) in image stream "openshift/php" under tag "7.1" for "php"

    Apache 2.4 with PHP 7.1 
    ----------------------- 
    PHP 7.1 available as container is a base platform for building and running various PHP 7.1 applications and frameworks. PHP is an HTML-embedded scripting language. PHP attempts to make it easy for developers to write dynamically generated web pages. PHP also offers built-in database integration for several commercial and non-commercial database management systems, so writing a database-enabled webpage with PHP is fairly simple. The most common use of PHP coding is probably as a replacement for CGI scripts.

    Tags: builder, php, php71, rh-php71

    * A source build using source code from https://github.com/sclorg/cakephp-ex.git will be created
      * The resulting image will be pushed to image stream tag "cakephp-app:latest"
      * Use 'start-build' to trigger a new build
    * This image will be deployed in deployment config "cakephp-app"
    * Ports 8080/tcp, 8443/tcp will be load balanced by service "cakephp-app"
      * Other containers can access this service through the hostname "cakephp-app"

--> Creating resources with label stack=lamp ...
    imagestream.image.openshift.io "cakephp-app" created
    buildconfig.build.openshift.io "cakephp-app" created
    deploymentconfig.apps.openshift.io "cakephp-app" created
    service "cakephp-app" created
--> Success
    Build scheduled, use 'oc logs -f bc/cakephp-app' to track its progress.
    Application is not exposed. You can expose services to the outside world by executing one or more of the commands below:
     'oc expose svc/cakephp-app' 
    Run 'oc status' to view your app.
$ oc expose svc/cakephp-app
$ oc logs -f bc/cakephp-app
```
