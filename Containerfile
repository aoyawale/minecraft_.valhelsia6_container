FROM quay.io/fedora/fedora:latest

# install Node.js + yarn

RUN dnf -y update && \
    dnf -y reinstall shadow-utils && \
    dnf install -y 
                   java
                   git
                   java-1.17.0-openjdk
RUN useradd minecraft
RUN  wget -O Valhelsia-6-6.1.0-SERVER.zip https://www.curseforge.com/api/v1/mods/878495/files/5174278/download
COPY eula.txt /home/minecraft/eula.txt
COPY ServerStart.sh /home/minecraft/ServerStart.sh 
COPY server.properties /home/minecraft/server.properties

RUN useradd -u 1000 podman-desktop && echo podman-desktop:10000:5000 > /etc/subuid && echo podman-desktop:10000:5000 > /etc/subgid

# Disable telemetry
RUN mkdir -p /home/podman-desktop/.local/share/containers/podman-desktop/configuration && \
    echo '{"telemetry.enabled": false, "telemetry.check": true}' > /home/podman-desktop/.local/share/containers/podman-desktop/configuration/settings.json

# expose port for VNC
EXPOSE 8080

# initialize conf files
ADD https://raw.githubusercontent.com/containers/libpod/master/contrib/podmanimage/stable/containers.conf /etc/containers/containers.conf
ADD https://raw.githubusercontent.com/containers/libpod/master/contrib/podmanimage/stable/podman-containers.conf /home/podman-desktop/.config/containers/containers.conf

# set permissions
RUN chown podman-desktop:podman-desktop -R /home/podman-desktop && chmod 644 /etc/containers/containers.conf && \
    mkdir -p /var/lib/shared/overlay-images /var/lib/shared/overlay-layers /var/lib/shared/vfs-images /var/lib/shared/vfs-layers; touch /var/lib/shared/overlay-images/images.lock; touch /var/lib/shared/overlay-layers/layers.lock; touch /var/lib/shared/vfs-images/images.lock; touch /var/lib/shared/vfs-layers/layers.lock && \
    mkdir -p /run/user/1000 && chown podman-desktop:podman-desktop /run/user/1000


ENV _CONTAINERS_USERNS_CONFIGURED=""

# socket path for podman
ENV XDG_RUNTIME_DIR=/run/user/1000

ENTRYPOINT [ "/entrypoint.sh" ]
USER podman-desktop
CMD ["tail", "-f", "/dev/null"]
