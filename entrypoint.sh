#!/bin/bash

# Generate a random secret for SSH
SECRET=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 16)

# Start SSH daemon
/usr/sbin/sshd

# Start cloudflare tunnel in foreground
# This creates a public URL that tunnels to SSH on port 2222
echo "SECRET: $SECRET"
cloudflared tunnel --url ssh://localhost:2222 2>&1 | grep --line-buffered "trycloudflare.com"
