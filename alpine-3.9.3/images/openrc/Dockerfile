from rootfs:alpine-3.9.3

# So that docker daemon will not use a read only mount
# of the host counterpart
VOLUME [ "/sys/fs/cgroup" ]

# Install the scripts for startup
RUN apk add --no-cache openrc busybox-initscripts

# Tailor the startup scripts for a stand alone environment which does not
# need most of those handling as they have been done in the host already.
RUN set -x \
    # Disable getty's
    && sed -i 's/^\(tty\d\:\:\)/#\1/g' /etc/inittab \
    && sed -i \
        # Change subsystem type to "docker"
        -e 's/#rc_sys=".*"/rc_sys="docker"/g' \
        # Allow all variables through
        -e 's/#rc_env_allow=".*"/rc_env_allow="\*"/g' \
        # Start crashed services
        -e 's/#rc_crashed_stop=.*/rc_crashed_stop=NO/g' \
        -e 's/#rc_crashed_start=.*/rc_crashed_start=YES/g' \
        # Define extra dependencies for services
        -e 's/#rc_provide=".*"/rc_provide="loopback net"/g' \
        /etc/rc.conf \
    # Remove unnecessary services
    && rm -f /etc/init.d/* \
    && ln -s /lib/rc/sh/functions.sh /etc/init.d/functions.sh \
    # Can't do cgroups
    && sed -i 's/cgroup_add_service /# cgroup_add_service /g' /lib/rc/sh/openrc-run.sh \
    && sed -i 's/VSERVER/DOCKER/Ig' /lib/rc/sh/init.sh

# Install sshd and enable it
RUN apk add --no-cache openssh \
    && echo 'PermitRootLogin yes' >>/etc/ssh/sshd_config \
    && rc-update add sshd boot

# Any image that inherits from this will have this entry point.
ENTRYPOINT [ "/sbin/init" ]
