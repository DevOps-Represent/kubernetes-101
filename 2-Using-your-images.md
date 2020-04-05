## Pushing your own image

What if you want to push your own images? It's fairly easy. For the purposes of brevity, we're not going to talk about how Docker works - for that, you can go to: https://docs.docker.com/ - or you can also check out our [Docker workshop](https://github.com/DevOps-Girls/docker-101/)

For this exercise, we'll build a Docker image, put out own file into it, and make it available to the web. We'll create our Dockerhub repo, and then we're going to push our image onto it.

#### Docker repositories

Docker repositories allow you to share your images with the community. To get started, we'll create a repository by [going to Docker Hub](https://hub.docker.com/) and selecting **Create A Repository**:

![Create-Repo](/images/6-create-repo.png)

Name it however you want. In the below example, we're calling it `/my-first-repo`:

![Private Repo](/images/7-create-repo.png)

We're setting it to **Public**.

#### Creating your Docker image

First off, open the `index.html` file in your `kubernetes-101` directory, and put whatever text you want on it. Say:

```
WASSUP DEVOPS GIRLS!
```

Then, it's time to build our image. In the command line, execute:

```
docker build -t nora-lim/my-first-repo .
```

Where `nora-lim` is your DockerHub username, and `my-first-repo` is the repository name you created. Finally, let's login to DockerHub:

```
docker login
```

Use your Docker Hub credentials to login. Once you're logged in, you can push your image to Docker Hub:

```
docker push banana-smith/my-first-repo
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
        - image: "nora-lim/my-first-repo"
          name: nginx
          ports:
            - containerPort: 80
```

Visit `devopsgirls.blah.com` - as per the first set of instructions. Hopefully, you'll be able to see your index.html file!
