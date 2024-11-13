FROM kalilinux/kali-rolling

# Update and install necessary packages
RUN apt update && apt upgrade -y && apt dist-upgrade -y && \
    apt install -y \
    kali-desktop-xfce \  # Install full Xfce desktop environment (can replace with kali-desktop-gnome for GNOME)
    xfce4 \
    xfce4-goodies \
    xrdp \
    dbus-x11 \
    sudo \
    tightvncserver \
    kali-linux-large \  # Install all the tools from the Kali Linux Large set
    && apt clean

# Enable SSH and RDP
RUN systemctl enable ssh && \
    systemctl enable xrdp

# Expose SSH and RDP ports
EXPOSE 22 3389

# Start SSH and xRDP services
CMD ["/usr/sbin/sshd", "-D"]
