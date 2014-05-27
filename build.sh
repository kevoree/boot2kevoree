rm boot2kevoree.iso
docker pull boot2docker/boot2docker
docker build -t boot2kevoree-img -rm=true .
docker run -i --rm boot2kevoree-img /bin/cat /boot2docker.iso > boot2kevoree.iso