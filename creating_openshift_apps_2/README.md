## Deploy Apache v1 image using new-app

```
$ oc new-app --docker-image=lakshminp/apache:v1 -l method=new-app
```

## Get all the resouces created by new-app above

```
$ oc get all -l method=new-app
```

## Update no. of replicas

```
$ oc patch deploymentconfig.apps.openshift.io/apache -p '{"spec":{"replicas":2}}'
deploymentconfig.apps.openshift.io/apache patched
```

## Confirm desired pods are created

```
$ oc get pods -l method=new-app
NAME               READY     STATUS    RESTARTS   AGE
apache-1-gbscp     1/1       Running   0          3m
apache-1-m45n9     1/1       Running   0          19s

```

## Expose the app

```
$ oc expose svc/apache
```

## Building apps from docker images

```
$ oc new-app https://github.com/badri/go-app.git --name=go-app
$ oc expose svc/go-app
```

## Redeploy

Change the code.

```
$ oc start-build go-app
```

## S2I

```
$ oc new-app https://github.com/badri/python-app.git
$ oc expose svc/python-app
```
