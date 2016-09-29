#!/usr/bin/env sh

# Generate configs

bash /usr/app/.hz/config.toml.sh
bash /usr/app/.hz/schema.toml.sh
bash /usr/app/.hz/secrets.toml.sh

cat /usr/app/.hz/schema.toml

su -s /bin/sh horizon -c "hz serve /usr/app"
