#! /bin/sh

cd /root/.kube/images

for img in * ; do
  docker load --input $img
done
