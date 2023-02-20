# How to work with
## Set-up
1. Create variables.env based on variables.env-template
2. ``` make build ```
3. ``` make start ```
4. Commands ``` make shell ``` and ``` make notebook ``` allow you for interaction with main utility container


## Nvidia CUDA install for docker
Make sure that the version od Nvidia driver installed on the system is the same as one in Dockerfile.

```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
```

## TODO 
- jupyter configuration
- think about pushing, what is usefull for me