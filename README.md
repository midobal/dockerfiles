# Dockerfiles
This repos contains personalized Dockerfiles for different tasks.

## List of Dockerfiles

## Docker installation
You can download and install the bleeding edge version of docker by running the following command:
```
 curl -fsSL https://get.docker.com -o get-docker.sh && chmod +x get-docker.sh && sudo sh get-docker.sh
```

### GPU compatibility
In order to use your GPU inside your docker container, you need to install `nvidia-container-toolkit`. You can do so by running the following commands:

```
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install nvidia-container-toolkit
```

### Add user to docker group
By deffault, docker needs sudo permissions. However, you can add a user to the docker group to give them permission:

```
 sudo usermod -aG docker $username
```

(The user needs to log out and log back in for the change to take effect.)
