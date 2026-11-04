#!/usr/bin/with-contenv bashio

MANAGER_API_URL="$(bashio::config 'manager_api_url')"
AGENT_TOKEN="$(bashio::config 'agent_token')"

# add date to default bashio log timestamp
declare __BASHIO_LOG_TIMESTAMP="%Y-%m-%d %T"

if [[ -z "${MANAGER_API_URL}" || -z "${AGENT_TOKEN}" ]]; then
    bashio::log.error "Set the Arcane Manager API URL and Agent Token in the app configuration."
    exit 1
fi

MODE="$(bashio::config 'mode')"
ENVIRONMENT="$(bashio::config 'environment')"
LISTEN="$(bashio::config 'listen')"

export AGENT_TOKEN MANAGER_API_URL
[[ -n "${ENVIRONMENT}" ]] && export ENVIRONMENT

if [[ "${MODE}" == "edge" ]]; then
    bashio::log.info "Starting Arcane Agent in edge mode (poll)"
    export EDGE_AGENT=true EDGE_TRANSPORT=poll
else
    bashio::log.info "Starting Arcane Agent in direct mode on port 3553"
    export AGENT_MODE=true PORT=3553
    [[ -n "${LISTEN}" ]] && export LISTEN
fi
mkdir -p /app/data
cd /app
exec /arcane-agent
