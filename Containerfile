FROM quay.io/fedora/fedora:latest

# install Node.js + yarn

RUN dnf -y update && \
    dnf -y reinstall shadow-utils && \
    dnf install -y 
                   java
                   git
                   java-1.17.0-openjdk
RUN useradd minecraft
RUN  wget -O /home/minecraft/Valhelsia-6-6.1.0-SERVER.zip https://www.curseforge.com/api/v1/mods/878495/files/5174278/download
COPY eula.txt /home/minecraft/eula.txt
COPY ServerStart.sh /home/minecraft/ServerStart.sh 
COPY server.properties /home/minecraft/server.properties
RUN rm -rf /home/minecraft/Valhelsia-6-6.1.0-SERVER.zip
EXPOSE 8080

# initialize conf files
ADD
ADD 
ADD
RUN /home/minecraft/ServerStart.sh &


