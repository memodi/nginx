# Nginx server image with custom object sizes

## Spin up nginx server pod
```bash
oc new-project test
oc apply -f nginx-deployment.yaml
```

## Spin up http client pod

Currently nginx server image includes 1K, 10K, 1M replace 1K object size to any size you need `curl ${NGINX_PODIP}:8080/1K` in `web-client.yaml`. Feel free to reach out if you need other sizes of objects.
Update client with nginx service IP

```bash
export NGINX_PODIP=$(oc get pods -o jsonpath='{.items[*].status.podIP}')
```

```bash
envsubst < web-client.yaml > /tmp/web-client.yaml
oc apply -f /tmp/web-client.yaml
```

## Verify pods are up and nginx server pods are responding with 200s:
```bash
$ oc get pods
NAME                     READY   STATUS    RESTARTS   AGE
bbx                      1/1     Running   0          4s
nginx-68696c7fdb-r9x9c   1/1     Running   0          13m

$ oc logs pod/nginx-68696c7fdb-r9x9c | tail -5
10.131.0.21 - - [25/Aug/2022:14:41:13 +0000] "GET /1K HTTP/1.1" 404 153 "-" "curl/7.79.1" "-"
10.131.0.22 - - [25/Aug/2022:14:41:40 +0000] "GET /data/1K HTTP/1.1" 200 1024 "-" "curl/7.79.1" "-"
10.131.0.22 - - [25/Aug/2022:14:42:40 +0000] "GET /data/1K HTTP/1.1" 200 1024 "-" "curl/7.79.1" "-"
10.131.0.22 - - [25/Aug/2022:14:43:40 +0000] "GET /data/1K HTTP/1.1" 200 1024 "-" "curl/7.79.1" "-"
10.131.0.22 - - [25/Aug/2022:14:44:40 +0000] "GET /data/1K HTTP/1.1" 200 1024 "-" "curl/7.79.1" "-"
```
