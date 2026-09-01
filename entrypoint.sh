#!/bin/bash

# Generate a random secret
SECRET=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 16)

# Start wetty (web terminal) on port 7681, running bash directly
wetty --port 7681 --host 0.0.0.0 -c user:bash &

echo "SECRET: $SECRET"
echo "Web terminal starting..."

# Start cloudflare tunnel to web terminal
cloudflared tunnel --url http://localhost:7681
