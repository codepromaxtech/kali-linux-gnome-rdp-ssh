FROM kalilinux/kali-rolling:latest

# Update package list and install necessary dependencies
RUN apt-get update
RUN apt-get install -y sudo xfce4 xfce4-goodies xorg tightvncserver kali-desktop-xfce browser xrdp
RUN apt-get clean
# Setup VNC server
RUN mkdir -p ~/.vnc && \
    echo "password" | vncpasswd -f > ~/.vnc/passwd && \
    chmod 600 ~/.vnc/passwd

# Expose ports for VNC and RDP
EXPOSE 5901
EXPOSE 3389

# Start the services
CMD tightvncserver :1 -geometry 1280x1024 -depth 24 && \
    xrdp-sesman && \
    xrdp
