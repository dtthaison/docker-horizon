#!/usr/bin/env sh

CONFIG_FILE=/usr/app/.hz/config.toml

HORIZON_BIND=${HORIZON_BIND:-"all"}
# HORIZON_PORT=${HORIZON_PORT:-"8181"}

HORIZON_SECURE=${HORIZON_SECURE:-false}

HORIZON_PROJECT_NAME=${HORIZON_PROJECT_NAME:-"test"}

HORIZON_AUTO_CREATE_COLLECTION=${HORIZON_AUTO_CREATE_COLLECTION:-false}
HORIZON_AUTO_CREATE_INDEX=${HORIZON_AUTO_CREATE_INDEX:-false}

HORIZON_RETHINKDB_URI=${HORIZON_RETHINKDB_URI:-"localhost:28015"}
HORIZON_START_RETHINKDB=${HORIZON_START_RETHINKDB:-false}
HORIZON_RDB_TIMEOUT=${HORIZON_RDB_TIMEOUT:-30}

HORIZON_DEBUG=${HORIZON_DEBUG:-false}

HORIZON_ALLOW_ANONYMOUS=${HORIZON_ALLOW_ANONYMOUS:-false}
HORIZON_ALLOW_UNAUTHENTICATED=${HORIZON_ALLOW_UNAUTHENTICATED:-false}
HORIZON_AUTH_REDIRECT=${HORIZON_AUTH_REDIRECT:-"/"}
HORIZON_ACCESS_CONTROL_ALLOW_ORIGIN=${HORIZON_ACCESS_CONTROL_ALLOW_ORIGIN:-""}

cat << EOF > ${CONFIG_FILE}

# This is a TOML file

###############################################################################
# IP options
# 'bind' controls which local interfaces will be listened on
# 'port' controls which port will be listened on
#------------------------------------------------------------------------------
bind = [ "${HORIZON_BIND}" ]
port = ${PORT}


###############################################################################
# HTTPS Options
# 'secure' will disable HTTPS and use HTTP instead when set to 'false'
# 'key_file' and 'cert_file' are required for serving HTTPS
#------------------------------------------------------------------------------
secure = $HORIZON_SECURE
# key_file = "horizon-key.pem"
# cert_file = "horizon-cert.pem"


###############################################################################
# App Options
# 'project_name' sets the name of the RethinkDB database used to store the
#                application state
# 'serve_static' will serve files from the given directory over HTTP/HTTPS
#------------------------------------------------------------------------------
project_name = "$HORIZON_PROJECT_NAME"
# serve_static = "dist"


###############################################################################
# Data Options
# WARNING: these should probably not be enabled on a publically accessible
# service.  Tables and indexes are not lightweight objects, and allowing them
# to be created like this could open the service up to denial-of-service
# attacks.
# 'auto_create_collection' creates a collection when one is needed but does not exist
# 'auto_create_index' creates an index when one is needed but does not exist
#------------------------------------------------------------------------------
auto_create_collection = $HORIZON_AUTO_CREATE_COLLECTION
auto_create_index = $HORIZON_AUTO_CREATE_INDEX


###############################################################################
# RethinkDB Options
# 'connect' and 'start_rethinkdb' are mutually exclusive
# 'connect' will connect to an existing RethinkDB instance
# 'start_rethinkdb' will run an internal RethinkDB instance
# 'rdb_timeout' is the number of seconds to wait when connecting to RethinkDB
#------------------------------------------------------------------------------
connect = "${HORIZON_RETHINKDB_URI}"
start_rethinkdb = $HORIZON_START_RETHINKDB
rdb_timeout = $HORIZON_RDB_TIMEOUT


###############################################################################
# Debug Options
# 'debug' enables debug log statements
#------------------------------------------------------------------------------
debug = $HORIZON_DEBUG


###############################################################################
# Authentication Options
# Each auth subsection will add an endpoint for authenticating through the
# specified provider.
# 'token_secret' is the key used to sign jwts
# 'allow_anonymous' issues new accounts to users without an auth provider
# 'allow_unauthenticated' allows connections that are not tied to a user id
# 'auth_redirect' specifies where users will be redirected to after login
# 'access_control_allow_origin' sets a host that can access auth settings
#   (typically your frontend host)
#------------------------------------------------------------------------------

allow_anonymous = $HORIZON_ALLOW_ANONYMOUS
allow_unauthenticated = $HORIZON_ALLOW_UNAUTHENTICATED
auth_redirect = "${HORIZON_AUTH_REDIRECT}"
access_control_allow_origin = "${HORIZON_ACCESS_CONTROL_ALLOW_ORIGIN}"
#

EOF
