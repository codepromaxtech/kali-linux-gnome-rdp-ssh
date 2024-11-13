FROM kalilinux/kali-rolling

# Update and install necessary packages
RUN apt update && \
    apt -y install kali-linux-large openssh-server && \
    systemctl enable ssh && \
    systemctl start ssh
# Expose SSH and RDP ports
EXPOSE 22 

# Start SSH and xRDP services
CMD ["/usr/sbin/sshd", "-D"]
