# Setup with Windows

### Installing a Hypervisor
  
A hypervisor allows you to create and run virtual machines. [VirtualBox](https://www.virtualbox.org/wiki/Downloads) will be the hypervisor we'll be using for this exercise, so make sure you download and install the packages for your operating system:

* [If you are running a Windows machine, use this link](https://download.virtualbox.org/virtualbox/6.0.14/VirtualBox-6.0.14-133895-Win.exe)

### Installing minikube

You can install `minikube` using Windows installer by downloading and installing [this package](https://github.com/kubernetes/minikube/releases/latest/download/minikube-installer.exe).

### Installing kubectl

`kubectl` is the command line tool we'll be using to interact with our local cluster - and in fact, any Kubernetes cluster in general.

To install `kubectl` in Windows, download [this executable](https://storage.googleapis.com/kubernetes-release/release/v1.16.0/bin/windows/amd64/kubectl.exe) and put it in the same path as this repository.

### Starting minikube

To start minikube, simply type the following in your terminal or command line:

```
minikube start
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

