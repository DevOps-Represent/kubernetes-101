# Services and Deployments

So the pod is up, now how do we access it?

In Kubernetes, there is an object type called a `service` which functions as a load balancer. What this means is that if someone needs to talk to or access a `Pod`, then they need to go through the `Service`.

![Kubes](/images/12-services.png)

### Services

We can create a service for your pod with the following command:

```
kubectl expose pod devopsgirls-pod --port=8000 --target-port=80 --name devopsgirls-service --type LoadBalancer
```

We can check if your service exists by listing them out, the same way we list out our pods:

```
kubectl get services
```

Which should give you an output that's similar to below:

```
$ kubectl get service
NAME                    TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
devopsgirls-service     ClusterIP   10.105.91.242    X.X.X.X        8000/TCP   5s
```

We can now access the services of your pod! Simply use your browser to access the `EXTERNAL-IP` as reported above (this may take time, so if it doesn't work, wait a bit and run `kubectl get service again`). Use the following URL, for example:

```
http://EXTERNAL-IP:8000/
```

You should see the Nginx greeting page! Now, to remove the service, we simply delete the `service` object just as we do any other object in Kubernetes:

```
kubectl delete service devopsgirls-service
```

Additionally, we can also use YAML to deploy the service. We can use the file at `kubes/service.yaml`, and run:

```
kubectl apply -f kubes/service.yaml
```

Again, we can check if the service exists using this command:

```
kubectl get service
```

### Deployments

As nice as it is that we can use a singular service to talk to things. But what happens when we delete a pod? Well, we can just tear it down and see what happens, right?

```
kubectl delete pod devopsgirls-pod
```

Now, try accessing the service again using the instructions above. Spoiler: it's not gonna work! Just as we need high availability for the applications we put out on the web, we need to make sure that our pods are highly available. So here come **deployments**.

**Deployments** are a set of declarative updates for Pods. What this means in a nutshell, is that with **Deployments**, you can *declare* your desired number and state for a group of pods. 

![Kubes](/images/12-deployments.png)


For reference, we can take a look at the contents of [this file](https://github.com/DevOps-Girls/from-docker-to-kubernetes/blob/master/kubes/deployment.yaml):

```
spec:
  replicas: 1
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

What the above YAML block says is that we want 1 pod (`replicas: 1`) running with the same pod declaration that we used earlier ( `image: "nginx:alpine"`, `ports:`, etc). To apply the file, we simply run the same `apply` command we used before:

```
kubectl apply -f kubes/deployment.yaml
```

We can then inspect our deployement with the same `get` command we used before:

```
kubectl get deployments
```

We can increase this number to 2 pods (`replicas: 2`) in `deployment.yaml` to run two pods with the same pod declaration:

```
kubectl apply -f kubes/deployment.yaml
```

Now, we can also see the pods we made! What do you see when you run the following command?

```
kubectl get pods
```

This should show us something similar to the following:

```
(devops-girls)$ kubectl get pods
NAME                                     READY   STATUS    RESTARTS   AGE
devopsgirls-deployment-d44844c8f-29tsn   1/1     Running   0          12s
devopsgirls-deployment-d44844c8f-qhqms   1/1     Running   0          12s
```

Now, watch what happens when we remove one of the pods! We can remove one of the pods in the deployment by running the same `delete` command we had earlier - but replacing the `pod name` for one of the pods above:

```
kubectl delete pod devopsgirls-deployment-d44844c8f-qhqms
```

Now, what do you see when you list the pods afterwards with a `kubectl get pods`? You should see the pods being created again, as follows:

```
(devops-girls)$ kubectl get pods
NAME                                     READY   STATUS              RESTARTS   AGE
devopsgirls-deployment-d44844c8f-29tsn   1/1     Running             0          2m11s
devopsgirls-deployment-d44844c8f-qnglw   0/1     ContainerCreating   0          6s
```

Neat, huh?

Cleaning up, if you're using Google Cloud, the default settings only allow two pods like this to run at one time.

We'll be doing some cool stuff later that'll use multiple pod declarations, so we should set the number of pods back to 1 pods (`replicas: 1`) and run:

```
kubectl apply -f kubes/deployment.yaml
```

UP NEXT...

[Labels](7-Labels.md)
