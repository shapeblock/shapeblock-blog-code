## Setup an automatic webhook

### Get the webhook url

```
$ oc describe bc/go-app | grep -i '/github$'
	URL:	https://192.168.42.18:8443/apis/build.openshift.io/v1/namespaces/go-apps/buildconfigs/go-app/webhooks/<secret>/github
```

### Find out the secret

```
$ oc get bc/go-app -o yaml
```

```
  triggers:
  - github:
      secret: XI7DcbqF024SSeiCzz1I
    type: GitHub
```

```
https://99.224.72.37:8443/apis/build.openshift.io/v1/namespaces/go-apps/buildconfigs/go-app/webhooks/XI7DcbqF024SSeiCzz1I/github
```


http://www.ultrahook.com/
https://blog.openshift.com/using-github-hooks-with-your-local-openshift-environment/
