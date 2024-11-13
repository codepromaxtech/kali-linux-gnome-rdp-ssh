FROM kalilinux/kali-rolling

# Install GNOME desktop environment and other necessary tools
RUN apt-get update && apt-get install -y \
    kali-desktop-gnome \   # Install the GNOME desktop environment
    gnome-core \            # Install GNOME core packages
    xrdp \                  # Install xRDP for remote desktop access
    dbus-x11 \              # Install D-Bus (required for GNOME)
    sudo \                  # Install sudo for privilege escalation
    tightvncserver \        # Install TightVNC server
    kali-linux-large \      # Install all the tools from the Kali Linux Large set
    openssh-server \        # Install SSH server
    && apt-get clean

# Enable SSH and RDP
RUN systemctl enable ssh && \
    systemctl enable xrdp

# Expose SSH and RDP ports
EXPOSE 22 3389

# Start SSH and xRDP services
CMD ["/usr/sbin/sshd", "-D"]
