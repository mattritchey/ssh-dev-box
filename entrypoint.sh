#!/bin/bash

# Generate a random secret
SECRET=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 16)

# Start ttyd (web terminal) on port 7681 without auth
ttyd -p 7681 --writable bash &

echo "SECRET: $SECRET"
echo "Web terminal starting at https://ssh-dev-box.onrender.com"

# Start cloudflare tunnel to web terminal
cloudflared tunnel --url http://localhost:7681
