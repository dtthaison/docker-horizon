#!/usr/bin/env sh

CONFIG_FILE=/usr/app/.hz/secrets.toml

cat << EOF > ${CONFIG_FILE}

[groups.admin]
[groups.admin.rules.carte_blanche]
template = "any()"

EOF
