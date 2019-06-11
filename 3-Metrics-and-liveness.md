## Metrics and liveness

For this exercise, we're going to be deploying a new app. One with metrics and endpoints.

So first, login:

```
[Login to ECR bits]
```

Now, we need to build our app and push it:

```
docker build -t devopsgirls-training -f Dockerfile-app .
docker tag devopsgirls-training:latest XXXXXXXXX.dkr.ecr.ap-southeast-2.amazonaws.com/devopsgirls-training:nora-lim-customapp
```

Login, and push:

```
$(aws ecr get-login --no-include-email --region ap-southeast-2)
docker push XXXXXXXXX.dkr.ecr.ap-southeast-2.amazonaws.com/devopsgirls-training:nora-lim-customapp
```

Then, change names on `metrics/deployment.yaml` and `metrics/service.yaml` the same way you changed it earlier on the files on `basic/deployment.yaml` and `basic/service.yaml.` Make sure not to change anything else!

Then, apply the image on Kubernetes:

```
kubectl apply -f metrics/deployment.yaml -n training
kubectl apply -f metrics/service.yaml -n training
```

Once you go to your ingress, you should be able to see a new app. Go to `/metrics` - what do you see? For example, if your app is in `https://devopsgirls.blah.com/`, then you'll need to go to `https://devopsgirls.blah.com/metrics`


## Liveness and Readiness checks

You can also add Liveness checks and Readiness Checks specific to your containers. All it takes is to add the following lines to your deployment:

```
              livenessProbe:
                httpGet:
                  path: /health
                  port: $((containerPort))
                initialDelaySeconds: 3
                periodSeconds: 3
              readinessProbe:
                httpGet:
                  path: /ready
                  port: $((containerPort))
                initialDelaySeconds: 3
                timeoutSeconds: 8
                periodSeconds: 10
```

Note that the two are different. These are endpoints in your app (like `/metrics`) that are probed, and Kubernetes acts accordingly. 

If an app fails a `livenessProbe`, then the app is restarted.

If an app succeeds a `readinessProbe`, then traffic can flow into it.

Add the lines to your `metrics/deployment.yaml` as follows::

```
---
apiVersion: apps/v1beta2
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
        - image: "XXXXXXXXX.dkr.ecr.ap-southeast-2.amazonaws.com/devopsgirls-training:nora-lim-customapp"
          name: nginx
          ports:
            - containerPort: 3000
          livenessProbe:
            httpGet:
              path: /health
              port: 3000
            initialDelaySeconds: 3
            periodSeconds: 3
          readinessProbe:
            httpGet:
              path: /ready
              port: 3000
            initialDelaySeconds: 3
            timeoutSeconds: 8
            periodSeconds: 10
```

Apply your changes afterwards.

```
kubectl apply -f metrics/deployment.yaml -n training
```

## Exercise

Try putting a fake URL on your `readinessProbe` - then applying the change. What happens afterwards? For example:

```
---
apiVersion: apps/v1beta2
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
        - image: "XXXXXXXXX.dkr.ecr.ap-southeast-2.amazonaws.com/devopsgirls-training:nora-lim-customapp"
          name: nginx
          ports:
            - containerPort: 3000
          livenessProbe:
            httpGet:
              path: /health
              port: 3000
            initialDelaySeconds: 3
            periodSeconds: 3
          readinessProbe:
            httpGet:
              path: /banana
              port: 3000
            initialDelaySeconds: 3
            timeoutSeconds: 8
            periodSeconds: 10
```

