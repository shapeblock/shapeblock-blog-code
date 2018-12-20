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

## Ubuntu lemp

### Build image

```
$ docker build -t lemp-s2i-ubuntu .
```
