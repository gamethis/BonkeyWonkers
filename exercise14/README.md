# Exercise 14 - Modern Auth: JWT, Signed Identity & ext_authz

Back to [Main](../README.md)

**Time limit:** 25 minutes

## Overview

A request path modeled on the Grid Migration Proxy: a client presents a JWT,
**Envoy** calls an **ext_authz** proxy to authenticate it, and on success the
proxy hands Envoy a **signed identity header** that it injects to the upstream.
The upstream trusts that identity **only** if it is correctly signed.

```text
client --(Bearer JWT)--> Envoy :8080
  Envoy -> ext_authz proxy :9000   (validate JWT, return signed identity)
  Envoy -> upstream :9090 with the identity   (upstream verifies signature)
  IdP / JWKS :9091   (mints tokens, publishes the signing key)
```

The proxy and the Envoy config build and run as-is, but the path is **not
secure or working**. Some logic is missing (`# TODO`) and some config is wrong.
Fix all of it so the `verify.sh` checks pass. You edit only **`proxy/main.go`**
and **`envoy.yaml`**.

## Environment Setup

In one terminal, start everything (builds the Go services, runs Envoy):

```shell
cd exercise14
./start.sh
```

In a second terminal, run the checks at any time:

```shell
cd exercise14
./verify.sh
```

**Do not modify** `start.sh`, `verify.sh`, `go.mod`, or anything under
`backend/` (the IdP/JWKS and the upstream).

## Provided Files

| File | Description |
|------|-------------|
| `proxy/main.go` | The ext_authz proxy — **you edit this** |
| `envoy.yaml` | Envoy front proxy config — **you edit this** |
| `backend/idp/` | IdP + JWKS; mints test tokens (do-not-edit) |
| `backend/upstream/` | App that verifies the signed identity (do-not-edit) |
| `start.sh` / `verify.sh` | Run + test harness (do-not-edit) |

## Part A: Validate the Token

The proxy currently accepts any well-formed token without checking its
signature — a forged token passes.

```bash
Edit proxy/main.go
```

**Requirement**: Reject a token whose signature does not verify against the
IdP's JWKS (RS256). A forged token must be denied; a valid one must pass.

## Part B: Sign the Identity

The proxy forwards the caller identity to the upstream unsigned, so the upstream
rejects it (and a client could forge it).

```bash
Edit proxy/main.go
```

**Requirement**: Send the identity in a form the upstream trusts — a signature
it can verify — so a valid caller's identity is accepted.

## Part C: Wire Up Envoy ext_authz

The `envoy.yaml` authorizes requests but is misconfigured: it fails open, and it
drops the identity header the proxy returns.

```bash
Edit envoy.yaml
```

**Requirement**: Requests must be denied when authorization does not succeed
(no fail-open), and the signed identity header the proxy returns must reach the
upstream.

## Part D: Validate

```bash
./verify.sh
```

**Expected Result**: every check passes — a **valid** token returns `200`, while
**forged**, **expired**, **wrong-audience**, and **no-token** requests are all
denied.

## Cleanup

Stop `start.sh` (Ctrl-C); it tears down the backends and the Envoy container.

## Exercise 14 Complete

Proceed to [Main](../README.md).
