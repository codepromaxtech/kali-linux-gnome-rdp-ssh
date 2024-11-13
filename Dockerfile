# Use Kali Linux rolling image (equivalent to Kali Linux Large)
FROM kalilinux/kali-rolling

# Set the maintainer label
LABEL maintainer="your-email@example.com"

# Update and install necessary packages
RUN apt update && apt upgrade -y && apt dist-upgrade -y && \
    apt install -y \
    kali-desktop-gnome \  # Install the GNOME desktop environment
    gnome-core \
    xrdp \
    dbus-x11 \
    sudo \
    tightvncserver \
    kali-linux-large \  # Install all the tools from the Kali Linux Large set
    openssh-server \  # Install SSH server
    && apt clean

# Enable and start xrdp service
RUN systemctl enable xrdp

# Set the default user (you can change the username and password)
RUN useradd -ms /bin/bash kali && echo "kali:kali" | chpasswd && adduser kali sudo

# Configure xrdp to listen on port 3355
RUN sed -i 's/3389/3355/' /etc/xrdp/xrdp.ini

# Configure SSH to listen on port 3344
RUN sed -i 's/#Port 22/Port 3344/' /etc/ssh/sshd_config

# Expose custom RDP and SSH ports
EXPOSE 3355 3344

# Start the supervisor to manage services
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
