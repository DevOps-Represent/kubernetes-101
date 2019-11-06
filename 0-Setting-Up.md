## Installing Prerequisites

Before we get started, we have a couple of things we need to set up. [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) runs a single-node Kubernetes cluster in your laptop - so you can practice setting things up without having an actual cluster.

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
