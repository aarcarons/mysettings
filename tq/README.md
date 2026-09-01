# tq

Query a Prometheus-compatible HTTP API (Thanos, Mimir, vanilla Prometheus, ...)
and print normalized JSON, meant for piping into `jq`.

```
tq '<promql>'                     # instant query
tq --range --since 30m '<promql>' # range query
tq --series '<selector>'
tq --labels
tq --label-values LABEL
```

Base URL precedence: `--profile` > `--url` > `TQ_URL` > `THANOS_URL`
(`TQ_URL` is a neutral-named alias; `THANOS_URL` is kept for backward
compatibility with existing scripts).

## Auth

For backends that need auth headers (bearer tokens, tenant headers, etc.),
use `--header`/`-H` (repeatable) or `--header-file` (one `NAME: VALUE` per
line — keeps secrets out of argv/process listings):

```
tq --header "Authorization: Bearer $TOKEN" '<promql>'
tq --header-file /path/to/headers '<promql>'
```

`tq` itself has zero built-in knowledge of any specific backend, auth
scheme, or tenant model — that's entirely driven by `--url`/env vars/header
flags, or by a connection profile (below).

## Connection profiles

For setups with more than one backend (an old and a new cluster, or a
backend only reachable through an authenticating proxy), define named
profiles in `~/.config/tq/config.json` (or `$XDG_CONFIG_HOME/tq/config.json`).
This file is entirely optional, lives outside this repo, and is only read
when you pass `--profile`/`--list-profiles`/`--show-profile`. Because a
profile's `auth_command` tells `tq` to execute a program, treat this file
as a trust boundary: `tq` refuses it outright if it's group- or
world-**writable**, and `chmod 600 ~/.config/tq/config.json` is recommended
regardless (it may also hold private URLs/headers).

```json
{
  "version": 1,
  "guidance": [
    "Query multiple profiles when coverage is uncertain.",
    "An empty result does not prove another profile lacks the data."
  ],
  "profiles": {
    "legacy": {
      "url": "https://example.internal/legacy-prometheus",
      "description": "Older backend, no auth required."
    },
    "current": {
      "url": "https://example.internal/proxy/prometheus",
      "description": "Current backend, reached through an authenticating proxy.",
      "guidance": ["Only covers data from 2026-01-01 onward; query 'legacy' too for anything older."],
      "headers": {"X-Scope-OrgID": "some-tenant"},
      "auth_command": {
        "command": ["my-org-cli", "print-token"],
        "header": "Authorization",
        "prefix": "Bearer ",
        "timeout": 30
      }
    }
  }
}
```

```
tq --profile current '<promql>'
tq --list-profiles
tq --show-profile current
```

`auth_command.command` is run directly (never through a shell). Its
stdout, surrounding whitespace stripped, becomes the header value (prefixed
by `auth_command.prefix`, default `"Bearer "`, targeting
`auth_command.header`, default `Authorization`). Output containing an
embedded newline is rejected. `-H`/`--header`/`--header-file` still
override a profile's headers on name collision — and if they already
supply the exact header `auth_command` would set, the credential command
is skipped entirely (so a broken credential helper can't block an
explicit manual override).

`--list-profiles` and `--show-profile` only ever print names, URLs,
descriptions, guidance, and booleans — never header values, tokens, or
`auth_command`'s command/output. They also never execute `auth_command`,
even for the profile you're inspecting.

## Tips (especially for scripted/agent use)

- An empty result from one backend does not prove another backend lacks
  the data — query multiple profiles/backends when coverage is uncertain.
- If backends were split by a migration boundary in time, consider
  querying each side of the boundary against the appropriate backend.

## Tests

```
python3 test_tq
```
