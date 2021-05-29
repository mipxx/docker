FROM ubuntu:hirsute

# install setup-scripts & configure system
RUN apt-get update
RUN apt-get full-upgrade --yes
RUN apt-get clean

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# samba
RUN apt-get install samba smbclient --yes
RUN apt-get clean
COPY config/smb.conf /etc/samba/smb.conf
RUN adduser -gecos 'user1' -shell '/bin/bash' --disabled-password user1
RUN echo user1:user1 | chpasswd
RUN (echo user1; echo user1) | smbpasswd -s -a user1
RUN mkdir /mixed && chown user1:user1 /mixed -R
RUN mkdir /private && chown user1:user1 /private -R
RUN mkdir /public && chown user1:user1 /public -R
RUN mkdir /time_machine && chown user1:user1 /time_machine -R

# wsdd
RUN apt-get install wget --yes
RUN apt-get clean
RUN wget https://raw.githubusercontent.com/christgau/wsdd/v0.6.4/src/wsdd.py -O /usr/bin/wsdd
RUN chmod +x /usr/bin/wsdd
RUN adduser -gecos 'wsdd' -shell '/bin/bash' --disabled-password wsdd

# avahi
RUN apt-get install avahi-daemon --yes
RUN apt-get clean
COPY config/avahi-daemon.conf /etc/avahi/avahi-daemon.conf
COPY config/smb.service /etc/avahi/services/smb.service

# entrypoint
COPY config/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 137/udp
EXPOSE 138/udp
EXPOSE 139/tcp
EXPOSE 445/tcp
EXPOSE 3702/udp
EXPOSE 5357/tcp

HEALTHCHECK --interval=60s --timeout=15s CMD smbclient -L \\localhost -U % -m SMB3

ENTRYPOINT [ "entry.sh"]
