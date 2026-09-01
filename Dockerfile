FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    openssh-server \
    git \
    curl \
    wget \
    htop \
    tmux \
    vim \
    nano \
    build-essential \
    python3 \
    python3-pip \
    jq \
    zip \
    unzip \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Install ttyd (web terminal)
RUN curl -sL https://github.com/nicm/ttyd/releases/latest/download/ttyd.x86_64 -o /usr/local/bin/ttyd && \
    chmod +x /usr/local/bin/ttyd

# Create user
RUN useradd -m -s /bin/bash user

# Setup SSH
RUN mkdir -p /home/user/.ssh && \
    chmod 700 /home/user/.ssh

# Copy public key
COPY authorized_keys /home/user/.ssh/authorized_keys
RUN chmod 600 /home/user/.ssh/authorized_keys && \
    chown -R user:user /home/user/.ssh

# Configure SSHD
RUN mkdir -p /run/sshd && \
    sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config && \
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication no" >> /etc/ssh/sshd_config && \
    echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config && \
    echo "UsePAM no" >> /etc/ssh/sshd_config

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 2222 7681

CMD ["/entrypoint.sh"]
