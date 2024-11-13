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
    supervisor \  # Install Supervisor
    && apt clean

# Enable and configure xrdp service to listen on port 3355
RUN sed -i 's/3389/3355/' /etc/xrdp/xrdp.ini

# Configure SSH to listen on port 3344
RUN sed -i 's/#Port 22/Port 3344/' /etc/ssh/sshd_config

# Set the default user (you can change the username and password)
RUN useradd -ms /bin/bash kali && echo "kali:kali" | chpasswd && adduser kali sudo

# Expose the custom RDP and SSH ports
EXPOSE 3355 3344

# Copy the Supervisor configuration file to the container
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Create the required directories for logs (optional, if you want to manage logs)
RUN mkdir -p /var/log/supervisor

# Start Supervisor as the main process in the container
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
