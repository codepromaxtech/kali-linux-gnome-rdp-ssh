FROM kalilinux/kali-rolling

# Update and install necessary packages
RUN apt update && apt upgrade -y \
    apt install -y \
    kali-linux-large \
    xrdp \
    dbus-x11 \
    sudo \
    tightvncserver && \
    apt clean

# Enable SSH and RDP
RUN systemctl enable ssh && \
    systemctl enable xrdp

# Expose SSH and RDP ports
EXPOSE 22 3389

# Start SSH and xRDP services
CMD ["/usr/sbin/sshd", "-D"]
