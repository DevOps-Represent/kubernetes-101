# Kubernetes 101 

## What this is

This is a short workshop (which can be self-driven) which goes through the basics of deploying applications to Kubernetes. Before going through this workshop, make sure you have completed the following:

 * [Docker 101](https://github.com/DevOps-Girls/docker-101)
 * [Command Line 101](https://github.com/DevOps-Girls/command-line-101)
 * [AWS 101](https://github.com/DevOps-Girls/devopsgirls-bootcamp)

I mean, you don't have to. But then again, *why not*?

## Prerequisites

Before we get started, we have a couple of things we need to set up. [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) runs a single-node Kubernetes cluster in your laptop - so you can practice setting things up without having an actual cluster.

### Installing Docker

Docker is the mechanism by which we create containers that we'll then deploy to Kubernetes. To install Docker, see the instructions here: ( [Instructions for Windows](https://docs.docker.com/v17.09/docker-for-windows/install/) / [Instructions for Macs](https://docs.docker.com/docker-for-mac/install/) )

Once you're done, make sure you signup for an account in [Docker Hub](https://hub.docker.com/). After signing up for an account, make sure you can login by running the following in your command line:

```
docker login
```


### Installing a Hypervisor

A hypervisor allows you to create and run virtual machines. [VirtualBox](https://www.virtualbox.org/wiki/Downloads) will be the hypervisor we'll be using for this exercise, so make sure you download and install the packages for your operating system:

* [If you are running a Windows machine, use this link](https://download.virtualbox.org/virtualbox/6.0.14/VirtualBox-6.0.14-133895-Win.exe)

* [If you are using a Mac machine, use this link](https://download.virtualbox.org/virtualbox/6.0.14/VirtualBox-6.0.14-133895-OSX.dmg)

### Installing minikube

The easiest way to install `minikube` on Mac/OSX is to use Homebrew:

```
brew install minikube
```

If you are using Windows, you can install `minikube` using Windows installer by downloading [this package](https://github.com/kubernetes/minikube/releases/latest/download/minikube-installer.exe).

### Installing kubectl

`kubectl` is the command line tool we'll be using to interact with our local cluster - and in fact, any Kubernetes cluster in general. 

To install `kubectl` in Mac/OSX, simply use Homebrew:

```
brew install kubectl
```

To install `kubectl` in Windows, download [this executable](https://storage.googleapis.com/kubernetes-release/release/v1.16.0/bin/windows/amd64/kubectl.exe).


### Starting minikube

To start minikube, simply type the following in your terminal or command line:

```
minikube start
```

We also need to enable the ingress object, so that we can route traffic to our containers:

```
minikube addons enable ingress
```

This will setup the virtual machines required to run a minimal Kubernetes cluster. Once `minikube start` is finished, you can specify the `minikube` context from your command line:

```
kubectl config use-context minikube
```

To verify that you're connected to the cluster, you can run the following command:

```
kubectl cluster-info
```

Huzzah! You're ready!
