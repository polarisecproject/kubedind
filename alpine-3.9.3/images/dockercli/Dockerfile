# This container can access host's docker daemon.
# To use it, start the container with command line flags:
# "-v /var/run/docker.sock:/var/run/docker.sock" and
# "-v /usr/bin/docker:/usr/bin/docker:ro".
from rootfs:alpine-3.9.3

# Shared libraries needed by docker binary.
RUN apk add --no-cache libltdl
