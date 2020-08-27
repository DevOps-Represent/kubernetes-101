# Kubernetes Basics

In this part of the workshop, we're going to be talking about the basics of Kubernetes commands, and deploying a basic Pod.

### Running commands

Running commands in Kubernetes is very much similar to Docker. The command (`kubectl`) uses some verbs to define your actions (`get`, or `describe` or `create`). For example, run the following command to see all the nodes in your cluster:

```
kubectl get nodes
```

We can also grab specific nodes if we want. In the output of the above command, try doing a `get` on a specific node name (for example, `node1`):

```
kubectl get nodes node1
```

It's not a lot of information though. To list out all the capabilities of `kubectl`, simply execute it without specifying commands:

```
kubectl
```

For example, one of the commands that is listed is `describe`. We can use `describe` to provide more verbose output compared to our previous `get` command:

```
kubectl describe nodes node1
```

Finally, we can also run containers the same way we do in Docker. Remember the `nginx` container from before? We can run that container in the cluster with one command:

```
kubectl run devopsgirls --image=nginx
```

Where `--image=nginx` specifies that image that we're running on our cluster, and `devopsgirls` is the name of our pod. Once we execute the above, we can list out all the pods running in the cluster by doing a `get`:

```
kubectl get pods
```

Do you see your pods in the list? It should look like this:

```
$ kubectl get pods
NAME          READY   STATUS              RESTARTS   AGE
devopsgirls   0/1     ContainerCreating   0          2m41s
```

If you're happy with that, we can remove the pod with the following command:

```
kubectl delete pod devopsgirls
```

And we're cleaned up!


### Using YAML

We can recreate the pod again by running the following command:

```
kubectl run devopsgirls --image=nginx
```

This will recreate the pod. If you remember the previous commands, the `get` command grabs information regarding the pod that you specify. But did you know that there are several output types for that information? For example, you can run your `get` command like this:

```
kubectl get pods devopsgirls -o yaml
```

This will format the output as YAML - a human-readable serialization language. Incidentally, this is the kind of format that Kubernetes expects when we create resources in the cluster. For example, see the file in`kubes/pod.yaml`:

```
# This is an example of a pod
---
apiVersion: v1
kind: Pod
metadata:
  name: "devopsgirls-pod"
  labels:
    name: "devopsgirls-pod"
spec:
  containers:
    - image: "nginx:alpine"
      name: nginx
```

This describes a `Pod` that we can deploy. We can deploy the pod using the file, with this command:

```
kubectl apply -f kubes/pod.yaml
```

You can see the pod being created if you list them, using the same command we used previously:

```
kubectl get pods devopsgirls-pod
```

Isn't that neat? But what it also means, is that we can change the pods that we have by changing the files that we use to deploy. For example, if we change the YAML file in use so that the names are the same, but the properties are different, we can use `kubes/pod-changed.yaml` to update our pods. The `kubes/pod-changed.yaml` file contains the following:

```
# This is an example of a pod
---
apiVersion: v1
kind: Pod
metadata:
  name: "devopsgirls-pod"
  labels:
    name: "devopsgirls-pod"
spec:
  containers:
    - image: "nginx:latest"
      name: nginx
```

This change changes the image in use from `nginx:alpine` to `nginx:latest`. We can apply it on top of our previous pod like so:

```
kubectl apply -f kubes/pod-changed.yaml
```

Now, what do we see when we execute the following command?

```
kubectl get pods devopsgirls-pod -o yaml
```

UP NEXT...

[Deployments and Services](6-Deployments-and-Services.md)
