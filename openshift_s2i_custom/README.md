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
$ oc new-app php-s2i-centos~https://github.com/sclorg/cakephp-ex.git --name=cakephp-app
```

### Confirm logs

```
$ oc logs -f bc/cakephp-app
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
$ docker build -t lakshminp/ubuntu-lemp-s2i .
```

### Test image

```
$ s2i build test/test-app lakshminp/ubuntu-lemp-s2i test-ubuntu-lemp-s2i
```

```
$ docker run -d -p 8080:8080 test-ubuntu-lemp-s2i
```

### Try in OpenShift

```
$ oc import-image lakshminp/ubuntu-lemp-s2i --confirm
```

### Run symfony demo application

```
$ s2i build ~/demo lakshminp/ubuntu-lemp-s2i test-ubuntu-lemp-s2i -e APP_ENV=prod -e APP_SECRET=67d829bf61dc5f87a73fd814e2c9f629 -e DATABASE_URL=sqlite:///%kernel.project_dir%/data/database.sqlite
```
