#!/usr/bin/env sh

CONFIG_FILE=/usr/app/.hz/schema.toml

HORIZON_SCHEMA=${HORIZON_SCHEMA:-""}

HORIZON_SCHEMA+=$(cat << EOF

[groups.admin]
[groups.admin.rules.carte_blanche]
template = "any()"


EOF
)

cat << EOF > ${CONFIG_FILE}

${HORIZON_SCHEMA}

EOF
