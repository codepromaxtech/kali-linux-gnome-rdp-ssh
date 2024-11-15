FROM debian:bullseye-slim

ENV USER=root

RUN apt-get update && apt-get install -y sudo xfce4 xfce4-goodies xorg tightvncserver xrdp kali-desktop-xfce && apt-get clean && rm -rf /var/lib/apt/lists/* && mkdir -p ~/.vnc && touch ~/.Xauthority && chmod 600 ~/.Xauthority && echo "password" | vncpasswd -f > ~/.vnc/passwd && chmod 600 ~/.vnc/passwd && echo -e "#!/bin/sh\nxrdb $HOME/.Xresources\nstartxfce4 &" > ~/.vnc/xstartup && chmod +x ~/.vnc/xstartup

EXPOSE 5901 3389

CMD tightvncserver :1 -geometry 1280x1024 -depth 24 && xrdp-sesman && xrdp
