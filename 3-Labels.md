# Deployments and Labels

So, deployments allow us to dynamically create pods according to our desired state. But if pods are changing all the time, how do we create a service for it?

**Labels** and **Selectors** allow us to associate services based on key-value pairs. **Labels** are key/value pairs that are attached to objects (like pods), and let us specify attributes to objects. **Selectors** allow us to specify criteria on what objects are associated with based on those criteria. 

![Kubes](/images/13-labels.png)

It's okay, we're going to break those down.

### Why labels?

If we inspect the YAML file for the deployment we had earlier, we're going to see the following labels:

```
  template:
    metadata:
      labels:
        app: "devopsgirls"
```

The above `labels` declaration basically means that every single `pod` that is created will have the key/value pair of `app: "devopsgirls"` associated with it. 

We can create a new set of pods by changing the `labels:` declaration.

Open up with the Google Console editor by clicking on **Open Editor**, and select the file in `kubes/deployment.yaml`. Change the file so it looks like this:

```
  template:
    metadata:
      labels:
        app: "devopsgirls"
        dark: "true"
```

Save your changes. Now, we can apply the labels by using the same `apply` command we were using before:

```
kubectl apply -f kubes/deployment.yaml
```

We can see how it affects our pods by running the following command:

```
kubectl get pods
```

or with more detail with:

```
kubectl describe pods
```

### Selectors

We can use **Selectors** as a means of *selecting* which objects to apply our changes to. 

![Kubes](/images/13-selectors.png)

If we inspect the file in `kubes/service.yaml`, we're going to see the following selector:

```
  selector:
    app: "devopsgirls"
```

This means that the `service` will only apply to the objects or pods that have the label `app: "devopsgirls"`. We can create the service with the same `apply` command that we used before:
 
```
kubectl apply -f kubes/service.yaml
```

Now, we can try exposing the service:

```
kubectl apply -f kubes/service-exposed.yaml
```

Running `kubectl get service` should show us the external IP we can use to see our deployments with our **browser**:

```
$ kubectl get service
NAME                    TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
devopsgirls-service     ClusterIP   10.105.91.242    X.X.X.X        8000/TCP   5s
```

Now...what happens if we remove one of the pods that the service is connected to? What we're going to find is that the service stays up - because *now* our infrastructure is highly available, as there are multiple pods running at the same time.


### Putting everything together

Now, remember the Docker image we published earlier? Well, we can now deploy it. The only thing we need to do is to change the `image` on our container spec to the repository where our image lives. This section, specifically:

```
    spec:
      containers:
        - image: "nginx:alpine"
```

We also don't have to have the components (deployments, services) in different files. We can use one file! So, if we open up the file in `kubes/combined.yaml` with our Google Console editor, we can have something that looks like this:

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
        - image: "mydockerusername/devopsgirls:latest"
          name: nginx
          ports:
            - containerPort: 80


---
apiVersion: v1
kind: Service
metadata:
  name: "devopsgirls-service"
spec:
  ports:
    - port: 80
      targetPort: 80
  selector:
    app: "devopsgirls"
```

Where `mydockerusername/devopsgirls:latest` is our Docker username, the repository, and the tag that we used. We can now deploy it using the same `apply` command we've been using:

```
kubectl apply -f kubes/combined.yaml
```

We can try to find the `EXTERNAL IP` of our new service with the following command:

```
kubectl get service
```

And finally, we can use our browser to see our deployed work!

```
http://<EXTERNAL-IP>
```

And hopefully, this shows our Docker image, running on Kubernetes, accessible on the web. Congratulations!
