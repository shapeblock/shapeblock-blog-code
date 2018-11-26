# Building the images

```
$ cd custom_image
```

Change `index.html` to point to whatever version you want.

```
$ docker build -t <your-namespace>/apache:v1 .
$ docker push <your-namespace>/apache:v1
```

# Getting image streams

```
$ oc get is
```

# Cleaning up all resources

```
$ oc delete all -l app=demo1
pod "apache-dc-3-7b8c2" deleted
pod "apache-dc-3-8qvqz" deleted
replicationcontroller "apache-dc-1" deleted
replicationcontroller "apache-dc-2" deleted
replicationcontroller "apache-dc-3" deleted
service "apache-service" deleted
deploymentconfig.apps.openshift.io "apache-dc" deleted
route.route.openshift.io "apache-service" deleted
```
