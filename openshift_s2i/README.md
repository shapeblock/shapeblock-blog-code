## Requirements

Download the latest s2i binaries from https://github.com/openshift/source-to-image/releases.

## Dissect an existing s2i image(Nginx)

Clone git@github.com:openshift/source-to-image.git.


Rebuild the nginx example image.

```
$ cd source-to-image/examples/nginx-centos7
$ docker build -t lakshminp/nginx-s2i .
$ docker run lakshminp/nginx-s2i
```


Push the inage to dockerhub(optional).

```
$ docker push lakshminp/nginx-s2i
```

Build a custom image with source code.

```
$ s2i build test/test-app lakshminp/nginx-s2i test-nginx
---> Building and installing application from source...
Build completed successfully
```

Run the resulting intermediate image.

```
$ docker run -d -p 8080:8080 test-nginx
e67d5b965c1ee7a3851ba7d4ce03338a0dc2976b3529859e445fb1a71d9e8285
```

Push the new s2i base image to OpenShift.

```
$ oc import-image lakshminp/nginx-s2i --confirm
```

Create new app from s2i image.

```
$ oc new-app nginx-s2i~https://github.com/adamwathan/theming-tailwind-demo.git
```

If the newly created pod throws any permission error with Nginx, use the official centos/nginx image.

```
$ oc new-app centos/nginx-18-centos7~https://github.com/adamwathan/theming-tailwind-demo.git --name tw2
$ oc expose svc/tw2
```

Each s2i consists of 3 essential parts:
1. The Dockerfile
2. assemble script
3. run script

and a few other optional parts:
1. save-artifacts script
2. usage script for printing usage



