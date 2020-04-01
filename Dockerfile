FROM ubuntu

RUN dpkg --add-architecture i386
RUN apt update ; apt upgrade -y
RUN apt install -y wget sudo gnupg
RUN apt install -y netcat gettext wine-stable
RUN apt install -y linux-sound-base alsa-base alsa-utils pciutils pulseaudio

#Install playonlinux (instructions on site)
RUN wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -
RUN wget http://deb.playonlinux.com/playonlinux_trusty.list -O /etc/apt/sources.list.d/playonlinux.list
RUN apt-get update -y
RUN apt-get install -y playonlinux

#Change encoding for correct language select screens in playonlinux
RUN sed -i 's/encoding = \"ascii\"/encoding = \"utf-8\"/g' /usr/lib/python2.7/site.py

#Cleanup
RUN apt-get autoremove &&\
    apt-get clean &&\
    rm -rf /tmp/*

# Create a user to run as
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/gamer && \
    echo "gamer:x:${uid}:${gid}:gamer,,,:/home/gamer:/bin/bash" >> /etc/passwd && \
    echo "gamer:x:${uid}:" >> /etc/group && \
    echo "gamer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/gamer && \
    chmod 0440 /etc/sudoers.d/gamer && \
    chown ${uid}:${gid} -R /home/gamer &&\
    usermod -a -G video gamer &&\
    usermod -a -G audio gamer

#NVIDIA : https://github.com/gklingler/docker3d/blob/master/ubuntuWithNvidiaDriver/Dockerfile
RUN apt-get install -y mesa-utils binutils module-init-tools
RUN cd /tmp ; wget http://fr.download.nvidia.com/XFree86/Linux-x86_64/340.107/NVIDIA-Linux-x86_64-340.107.run
RUN sh /tmp/NVIDIA-Linux-x86_64-340.107.run -a -N --ui=none --no-kernel-module
RUN rm /tmp/NVIDIA-Linux-x86_64-340.107.run

#Use created user
USER gamer
ENV HOME /home/gamer
ENV USER gamer

# Sound : https://bbs.archlinux.org/viewtopic.php?id=124380
ADD sound/asoundrc ~/.asoundrc

ENTRYPOINT ["playonlinux"]