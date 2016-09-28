#!/usr/bin/env sh

CONFIG_FILE=/usr/app/.hz/secrets.toml

HORIZON_TOKEN_SECRET=${HORIZON_TOKEN_SECRET:-"lfXnAWSJuXMfCHkZGUbOACx3K9JHbdbe6wGbHI6GDyCOLdE7pj8BcCDEn8zWjRKhSdpLAJQFKSv0JArkj09mFQ=="}

HORIZON_RDB_USER=${HORIZON_RDB_USER:-"admin"}
HORIZON_RDB_PASSWORD=${HORIZON_RDB_PASSWORD:-""}

auth=""

if ! [ -z "$HORIZON_AUTH_AUTH0_HOST" ] && ! [ -z "$HORIZON_AUTH_AUTH0_ID" ] && ! [ -z "$HORIZON_AUTH_AUTH0_SECRET" ] ; then
auth+=$(cat << EOF
#
[auth.auth0]
host = "${HORIZON_AUTH_AUTH0_HOST}"
id = "${HORIZON_AUTH_AUTH0_ID}"
secret = "${HORIZON_AUTH_AUTH0_SECRET}"
EOF
)
fi

if ! [ -z "$HORIZON_AUTH_FACEBOOK_ID" ] && ! [ -z "$HORIZON_AUTH_FACEBOOK_SECRET" ] ; then
auth+=$(cat << EOF

#
[auth.facebook]
id = "${HORIZON_AUTH_FACEBOOK_ID}"
secret = "${HORIZON_AUTH_FACEBOOK_SECRET}"
EOF
)
fi

if ! [ -z "$HORIZON_AUTH_GOOGLE_ID" ] && ! [ -z "$HORIZON_AUTH_GOOGLE_SECRET" ] ; then
auth+=$(cat << EOF

#
[auth.google]
id = "${HORIZON_AUTH_GOOGLE_ID}"
secret = "${HORIZON_AUTH_GOOGLE_SECRET}"
EOF
)
fi

if ! [ -z "$HORIZON_AUTH_TWITTER_ID" ] && ! [ -z "$HORIZON_AUTH_TWITTER_SECRET" ] ; then
auth+=$(cat << EOF

#
[auth.twitter]
id = "${HORIZON_AUTH_TWITTER_ID}"
secret = "${HORIZON_AUTH_TWITTER_SECRET}"
EOF
)
fi

if ! [ -z "$HORIZON_AUTH_GITHUB_ID" ] && ! [ -z "$HORIZON_AUTH_GITHUB_SECRET" ] ; then
auth+=$(cat << EOF

#
[auth.github]
id = "${HORIZON_AUTH_GITHUB_ID}"
secret = "${HORIZON_AUTH_GITHUB_SECRET}"
EOF
)
fi

if ! [ -z "$HORIZON_AUTH_TWITCH_ID" ] && ! [ -z "$HORIZON_AUTH_TWITCH_SECRET" ] ; then
auth+=$(cat << EOF

#
[auth.twitch]
id = "${HORIZON_AUTH_TWITCH_ID}"
secret = "${HORIZON_AUTH_TWITCH_SECRET}"
EOF
)
fi

if ! [ -z "$HORIZON_AUTH_SLACK_ID" ] && ! [ -z "$HORIZON_AUTH_SLACK_SECRET" ] ; then
auth+=$(cat << EOF

#
[auth.slack]
id = "${HORIZON_AUTH_SLACK_ID}"
secret = "${HORIZON_AUTH_SLACK_SECRET}"
EOF
)
fi

cat << EOF > ${CONFIG_FILE}
token_secret = "$HORIZON_TOKEN_SECRET"

rdb_user = '${HORIZON_RDB_USER}'
rdb_password = '${HORIZON_RDB_PASSWORD}'
${auth}

EOF
