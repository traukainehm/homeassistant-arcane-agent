# Arcane Agent

This Home Assistant app runs the official Arcane Agent in **direct** or **edge**
mode. It requires Supervisor and access to the host's Docker socket.

> **Protection mode must be disabled.** Open the app's **Info** tab, turn off
> **Protection mode**, then restart the app. Without this the app cannot access
> the host's Docker socket. Disabling it gives the app full control of Docker on
> the host, so only use it with a trusted Arcane Manager.

## Options

| Option | Required | Default | Description |
| --- | --- | --- | --- |
| `manager_api_url` | Yes | | Manager API URL from Arcane, for example `http://192.168.1.10:3552`. |
| `agent_token` | Yes | | Agent token generated for this environment in Arcane. |
| `mode` | Yes | `direct` | `direct` or `edge` (see below). |
| `environment` | No | `production` | Environment name passed to the agent. |
| `listen` | No | empty | Listen address, for example `127.0.0.1`. Direct mode only. |

## Modes

### Direct

The agent listens on port `3553` and the Arcane Manager connects to it.

1. In Arcane, open **Environments → Add Environment**, choose **Direct**, and
   create the environment before starting this app.
2. Set the Agent API URL in Arcane to the Home Assistant host's reachable
   address on port `3553`, for example `http://192.168.1.20:3553`.
3. Copy the generated `MANAGER_API_URL` and `AGENT_TOKEN` into this app's
   configuration, with `mode` set to `direct`.
4. Start the app. Make sure the Arcane Manager can reach TCP port `3553` on the
   Home Assistant host, including any firewall or router rules.

Keep the port reachable only by your Arcane Manager and trusted networks. Do not
use `localhost` for the Agent API URL unless the Manager runs on the same host
network.

### Edge

The agent polls the Arcane Manager, so no inbound port is needed. This suits
hosts behind NAT or a firewall.

1. In Arcane, create an **Edge** environment and copy the `MANAGER_API_URL` and
   `AGENT_TOKEN`.
2. Enter them in this app's configuration with `mode` set to `edge`.
3. Start the app.

## Data

Agent data is stored in the app's config folder, mapped to `/app/data`, and
should be included in Home Assistant backups.

See the [Arcane remote environment guide](https://getarcane.app/docs/remote/environments)
for details.
