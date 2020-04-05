## Deploying things

A basic service has three parts: a deployment, a service, and an ingress. 

A *deployment* is a declaration of a container or a group of containers - effectively your app. Look at the example in `basic/deployment.yaml` - and change `devopsgirls` to your name:

```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: "devopsgirls-deployment"
spec:
  replicas: 2
  selector:
    matchLabels:
      app: "devopsgirls"
  template:
    metadata:
      labels:
        app: "devopsgirls"
```

Change it to something like:

```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: "nora-lim-deployment"
spec:
  replicas: 2
  selector:
    matchLabels:
      app: "nora-lim"
  template:
    metadata:
      labels:
        app: "nora-lim"

```

Login, then deploy it like so:

```
kubectl apply -f basic/deployment.yaml -n training
```


A *service* is what routes the traffic to any of the pods. Because your pods may move instances or scale, you need a way to talk to any one of them. This is what a service is. Look at the example in `basic/service.yaml` and *again*, replace instances of `devopsgirls` with your name:

```
apiVersion: v1
kind: Service
metadata:
  name: "nora-lim-service"
spec:
  ports:
    - port: 80
      targetPort: 80
  selector:
    app: "nora-lim"
```

What the above basically means is that the `nora-lim-service` will connect to any pod that has the name `nora-lim`.

And deploy like so:

```
kubectl apply -f basic/service.yaml -n training
```

Finally, you'll need to have it surfaced to the net. This is what an *ingress* is for - see the example in `basic/ingress.yaml`, and *again*, replace instances of `devopsgirls` with your name. And deploy like so:

```
kubectl apply -f basic/ingress.yaml -n training
```

Now that everything's set up, feel free to see what the URL for your app is:

```
kubectl get ingress -n training
```

This will show something similar to:

```
NAME                  HOSTS                  ADDRESS        PORTS   AGE
devopsgirls-ingress   devopsgirls.blah.com   192.168.64.2   80      11s
```

To have the URL available for you to look at with your browser, you'll need to edit your `/etc/hosts` file (Mac/OSX) or `c:\windows\system32\drivers\etc\hosts` (Windows) with the following:

```
devopsgirls.blah.com 192.168.64.2
```

Where `192.168.64.2` is the IP address on shown on the ingress. You can now use your browser and go to `devopsgirls.blah.com` to access your deployment!

Now if you need to clean up, you just need to run:

```
kubectl delete -f basic/ingress.yaml -n training
```

Note that you don't have to deploy everything separately. You can just combine everything into one yaml. See `basic/combined.yaml` for an example, and deploy like how you've deployed everything else:

```
kubectl apply -f basic/combined.yaml -n training
```

## Exercise

Now that you can deploy a service, see if you can change the container running on your deployment. You should be able to see publicly available containers from: https://hub.docker.com/explore/

All you need to do is replace the name of the image and the tag in your `basic/deployment.yaml` file. See the part that says `nginx:alpine`


```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: "devopsgirls-deployment"
spec:
  replicas: 2
  selector:
    matchLabels:
      app: "devopsgirls"
  template:
    metadata:
      labels:
        app: "devopsgirls"
    spec:
      containers:
        - image: "nginx:alpine"
          name: nginx
          ports:
            - containerPort: 80
```

`nginx` refers to the Dockerhub image name, and `alpine` refers to the tag. Some you may want to try is `httpd`, `wordpress`

