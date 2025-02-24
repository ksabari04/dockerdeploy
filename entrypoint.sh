#!/bin/bash

# Start Apache in the background
apachectl -D FOREGROUND &

# Wait for Apache to fully started
sleep 5

# Run Certbot to obtain and configure SSL certificate
if [ -n "$VIRTUAL_HOST" ] && [ -n "$CERTBOT_EMAIL" ]; then
    certbot --apache -d "$VIRTUAL_HOST" --non-interactive --agree-tos -m "$CERTBOT_EMAIL"
else
    echo "Certbot skipped: VIRTUAL_HOST or CERTBOT_EMAIL not set"
fi

# Keep the container running
tail -f /dev/null
