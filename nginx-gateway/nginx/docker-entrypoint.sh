#!/bin/bash

set -e

if [[ "$OS_TYPE" == "mac" ]]; then
    TEMPLATE_FILE="/etc/nginx/conf.d/jy-default-mac.conf.template"
else
    TEMPLATE_FILE="/etc/nginx/conf.d/jy-default.conf.template"
fi

if [ "${NGINX_HTTPS_ENABLED}" = "true" ]; then
    # set the HTTPS_CONFIG environment variable to the content of the https.conf.template
    HTTPS_CONFIG=$(envsubst < /etc/nginx/https.conf.template)
    export HTTPS_CONFIG
    # Substitute the HTTPS_CONFIG in the default.conf.template with content from https.conf.template
    envsubst '${HTTPS_CONFIG}' < "$TEMPLATE_FILE" > /etc/nginx/conf.d/jy-default.conf
fi

env_vars=$(printenv | cut -d= -f1 | sed 's/^/$/g' | paste -sd, -)

envsubst "$env_vars" < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf
envsubst "$env_vars" < /etc/nginx/proxy.conf.template > /etc/nginx/proxy.conf

envsubst < "$TEMPLATE_FILE" > /etc/nginx/conf.d/jy-default.conf

# Start Nginx using the default entrypoint
exec nginx -g 'daemon off;'