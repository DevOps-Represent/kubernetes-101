## Pushing your own image

What if you want to push your own images? It's fairly easy. For the purposes of brevity, we're not going to talk about how Docker works - for that, you can go to: https://docs.docker.com/

For this exercise, we'll build a Docker image, put out own file into it, and make it available to the web. First off, open the `index.html` file in this directory, and put whatever text you want on it. Say:

```
WASSUP DEVOPS GIRLS!
```

Then, it's time to build our image. In the command line, execute:

```
docker build -t devopsgirls-training .
```

Then, we'll need to tag our custom container with our name. Replace <myname> below with your name:

```
docker tag devopsgirls-training:latest XXXXXXXXXXX.dkr.ecr.ap-southeast-2.amazonaws.com/devopsgirls-training:<myname>
```

For example:

```
docker tag devopsgirls-training:latest XXXXXXXXXXX.dkr.ecr.ap-southeast-2.amazonaws.com/devopsgirls-training:nora-lim
```

Finally, let's login to our AWS account:

```
$(aws ecr get-login --no-include-email --region ap-southeast-2)
```


And push our image to it:

```
docker push XXXXXXXXXXX.dkr.ecr.ap-southeast-2.amazonaws.com/devopsgirls-training:nora-lim
```

Afterwards, we can deploy this by changing the `basic/deployment.yaml` file to reflect the URL of the Docker image:

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
        - image: "xxxxxxxxx.dkr.ecr.ap-southeast-2.amazonaws.com/devopsgirls-training:nora-lim"
          name: nginx
          ports:
            - containerPort: 80
```
