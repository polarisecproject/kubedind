# Build docker image for kubernetes master and nodes.
#
# Start master or normal node by invoking following docker command:
# docker run --name <n> \
#            --hostname <n> \
#            --net <staticips> --ip <ip> \
#            --privileged \
#            -v /etc/shadow:/etc/shadow:ro \
#            -v /etc/resolv.conf:/etc/resolv.conf:ro \
#            -v kube:/root/.kube \
#            -d kubelet:alpine-3.9.3
#
# A master needs to be initialized by running following commands:
# kubeadm config images pull
# kubeadm init --pod-network-cidr 10.244.0.0/16 --kubernetes-version=v1.14.2 --token-ttl=0 \
#     --ignore-preflight-errors=all --apiserver-advertise-address=<ip>\
# cp -i .kube/config
#
# You can save k8s docker images obtained by "kubeadm config images pull" by invoking
# kube_save_images.sh command, which saves them to /root/.kube/images. The images can
# be loaded to other node by invoking kube_load_images.sh, if the volume
# /root/.kube is shared among all nodes in the cluster.
#
# A normal node needs to be initialized so that it can join k8s cluster:
# kubeadm join 172.16.4.1:6443 --token <token> --discovery-token-ca-cert-hash <hash> \
#     --ignore-preflight-errors=all
#
from vhost:alpine-3.9.3 as run1
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >>/etc/apk/repositories
RUN apk add --no-cache kubernetes

from vhost:alpine-3.9.3
VOLUME ["/var/lib/kubelet"]
VOLUME ["/etc/kubernetes"]
VOLUME ["/etc/cni"]
VOLUME ["/root/.kube"]
COPY --from=run1 /usr/bin/kubelet /usr/bin/kubeadm /usr/bin/kubectl /usr/bin/
COPY kubelet /etc/init.d/
COPY kube_save_images.sh kube_load_images.sh kill_all_containers.sh /usr/bin/
RUN rc-update add kubelet boot \
    && mkdir -p /opt/cni/bin \
    && cd /opt/cni/bin \
    && wget https://github.com/containernetworking/plugins/releases/download/v0.6.0/cni-plugins-amd64-v0.6.0.tgz \
    && tar xf /opt/cni/bin/cni-plugins-amd64-v0.6.0.tgz \
    && rm /opt/cni/bin/cni-plugins-amd64-v0.6.0.tgz
