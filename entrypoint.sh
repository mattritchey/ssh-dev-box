#!/bin/bash

# Generate a random secret
SECRET=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 16)

# Start SSH daemon
/usr/sbin/sshd

# Start ttyd (web terminal) on port 7681
ttyd -p 7681 -c user:$SECRET bash &

echo "SECRET: $SECRET"
echo "Web terminal will be available at the tunnel URL"

# Start cloudflare tunnel to web terminal
cloudflared tunnel --url http://localhost:7681
