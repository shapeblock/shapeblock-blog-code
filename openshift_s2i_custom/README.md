## Custom Ubuntu based PHP s2i

### Build image

```
$ docker build -t shapeblock/ubuntu-lemp-s2i:7.2 .
```

### Test image

```
$ s2i build test/test-app shapeblock/ubuntu-lemp-s2i:7.2 test-ubuntu-lemp-s2i
```

```
$ docker run -d -p 8080:8080 test-ubuntu-lemp-s2i
```

### Try in OpenShift

Please push the image to a registry before importing in OpenShift.

```
$ docker push shapeblock/ubuntu-lemp-s2i:7.2
```

```
$ oc import-image shapeblock/ubuntu-lemp-s2i:7.2 --confirm
```

### Run symfony demo application

```
$ s2i build ~/demo shapeblock/ubuntu-lemp-s2i test-ubuntu-lemp-s2i -e APP_ENV=prod -e APP_SECRET=67d829bf61dc5f87a73fd814e2c9f629 -e DATABASE_URL=sqlite:///%kernel.project_dir%/data/database.sqlite
```

### Create a new app

```
$ oc new-app ubuntu-lemp-s2i~https://github.com/symfony/demo.git --name=symfony-demo-1 --build-env APP_ENV=prod --build-env APP_SECRET=foobar123 --build-env DATABASE_URL=sqlite:///%kernel.project_dir%/data/database.sqlite
```
