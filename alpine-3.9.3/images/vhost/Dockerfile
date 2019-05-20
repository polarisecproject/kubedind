from openrc:alpine-3.9.3

# Containers needs to find a persistent place to hold the contents
# of docker service.
VOLUME [ "/var/lib/docker" ]

# Docker deamon depends on those services
COPY cgroups sysfs /etc/init.d/

RUN apk add --no-cache docker iproute2 vim git python \
    && rc-update add sysfs boot \
    && rc-update add cgroups boot \
    && rc-update add docker boot
