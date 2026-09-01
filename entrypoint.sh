#!/bin/bash

# Generate a random secret for SSH
SECRET=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 16)

# Start SSH daemon
/usr/sbin/sshd

echo "SECRET: $SECRET"
echo "SSH ready on port 2222"

# Keep container alive
tail -f /dev/null
