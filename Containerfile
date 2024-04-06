FROM quay.io/fedora/fedora:latest

# Update image, install needed rpms and set up system

RUN dnf -y update && \
    dnf install -y git java wget 
#java-1.17.0-openjdk
RUN useradd minecraft
RUN  wget -O /home/minecraft/Valhelsia-6-6.1.0-SERVER.zip https://www.curseforge.com/api/v1/mods/878495/files/5174278/download
RUN chown minecraft:minecraft Valhelsia-6-6.1.0-SERVER.zip
RUN unzip Valhelsia-6-6.1.0-SERVER.zip
COPY eula.txt /home/minecraft/eula.txt
COPY ServerStart.sh /home/minecraft/ServerStart.sh 
COPY server.properties /home/minecraft/server.properties
RUN rm -rf /home/minecraft/Valhelsia-6-6.1.0-SERVER.zip
EXPOSE 25565 25575

# ADD Variables
ENV VERSION='6-6.1.0'

#ADD
#ADD 
#ADD
RUN /home/minecraft/ServerStart.sh &


