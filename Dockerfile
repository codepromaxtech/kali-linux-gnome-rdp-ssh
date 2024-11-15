FROM kalilinux/kali-rolling:latest

# Set the environment variable to avoid 'USER' not set error
ENV USER=root

# Update package list and install necessary dependencies
RUN apt-get update && apt-get install -y \
    sudo \
    xfce4 \
    xfce4-goodies \
    xorg \
    tightvncserver \
    kali-desktop-xfce \
    xrdp \
    xauth \
    dbus-x11 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Setup VNC server
RUN mkdir -p /root/.vnc && \
    echo "password" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

# Create .Xauthority file for X11 authentication
RUN touch /root/.Xauthority

# Create the startup script directly in the Dockerfile
RUN echo '#!/bin/bash\n\
# Start VNC server\n\
tightvncserver :1 -geometry 1280x1024 -depth 24\n\
# Start XRDP session manager\n\
service xrdp-sesman start\n\
# Start XRDP server\n\
service xrdp start\n\
# Keep the container running\n\
tail -f /dev/null' > /root/startup.sh && \
    chmod +x /root/startup.sh

# Expose ports for VNC and RDP
EXPOSE 5901 3389

# Define the command to run the services
CMD ["/root/startup.sh"]
