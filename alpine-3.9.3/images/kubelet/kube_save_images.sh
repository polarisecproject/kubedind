#! /bin/sh

images=$(docker images | grep -v "REPOSITORY" | cut -f 1 -d " ")
mkdir -p /root/.kube/images

for img in $images ; do
  name=$(echo $img | cut -f 2 -d "/")
  docker save $img -o /root/.kube/images/$name.tar
done
