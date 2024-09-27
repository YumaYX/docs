---
layout: post
category: linux
---

install docker @ RHEL based distribution

```sh
sudo yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine \
                  podman \
                  runc

sudo yum install -y yum-utils

sudo yum-config-manager -y --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl start docker
sudo docker run hello-world

curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
```

https://docs.docker.com/engine/install/rhel/

