## Build configs

### Docker based build config

Add deploy/Dockerfile and checkin.

Create a docker strategy based build config.

```
$ oc apply -f drupal-docker-bc.yml
```

Fire a new build.

```
$ oc start-build drupal-8-docker-bc
```

Check logs.

```
$ oc logs bc/drupal-8-docker-bc
```


#### Docker based build config from private repo


### s2i based build

#### build s2i image

Build Drupal s2i image.

Add new image to existing deployment config.

#### Create s2i build config

Build the s2i image.

```
$ docker build -t lakshminp/drupal-openshift-s2i:v1.0 .
```

Test it locally.

```
$ s2i build drupal-code-base-dir lakshminp/drupal-openshift-s2i:v1.0 test-drupal-s2i
```

Run the newly created final image.

```
$ docker run -d test-drupal-s2i
```

Push image to public registry.

```
docker push lakshminp/drupal-openshift-s2i:v1.0
```

Push image to OpenShift registry.

```
$ oc import-image lakshminp/drupal-openshift-s2i:v1.0 --confirm
```

set incremental to true.


create the build config.

```
$ oc apply -f drupal-s2i-bc.yml
```

setup uphook.


```
$ echo "api_key: MUjwGMDT5bB6NMZpEsDRW9fXokxzMd1u" > ~/.ultrahook

```

Get Webhook URL.

```
$ oc describe bc/drupal-8-s2i-bc
```

https://192.168.42.176:8443/apis/build.openshift.io/v1/namespaces/openshift/buildconfigs/drupal-8-s2i-bc/webhooks/xuqEEupGL5RQfZnlkgLieMluPvyaOKuQWBzcg3Rq/github



docker run lakshminp/ultrahook -k MUjwGMDT5bB6NMZpEsDRW9fXokxzMd1u github https://192.168.42.176:8443/apis/build.openshift.io/v1/namespaces/openshift/buildconfigs/drupal-8-s2i-bc/webhooks/xuqEEupGL5RQfZnlkgLieMluPvyaOKuQWBzcg3Rq/github
Authenticated as lakshminp
Forwarding activated...
http://github.lakshminp.ultrahook.com -> https://192.168.42.176:8443/apis/build.openshift.io/v1/namespaces/openshift/buildconfigs/drupal-8-s2i-bc/webhooks/xuqEEupGL5RQfZnlkgLieMluPvyaOKuQWBzcg3Rq/github


make code change

```
$ composer require drupal/admin_toolbar
$ git commit -a -m "Added admin toolbar"
$ git push origin master
```

do a git push.

verify new deployment.

Testing incremental builds.


NOTE: you can do the same thing using docker build also.

## Templates

Create new template file by adding build config, route and imagestream.

Assemble all resources in a single file.

Parameterize values.

default parameter names.

Add parameters to a file.

Create new app from template.

make sure the s2i image is in your namespace.

```
$ oc import-image lakshminp/drupal-openshift-s2i:v1.0 --confirm
```
Dry run.

```
$ oc process -f drupal-8-template.yml -p NAMESPACE=drupal | oc apply --dry-run --validate -f -
```

Create resources.

```
$ oc process -f drupal-8-template.yml -p NAMESPACE=drupal | oc apply -f -
```

Start a deploy.

```
$ oc start-build drupal-8-7c36d6-bc
```



### Upload template to UI

### Create new app from UI
