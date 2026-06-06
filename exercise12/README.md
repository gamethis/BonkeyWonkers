# Exercise 12 - Go Reverse Proxy: Diagnose, Fix & Extend

Back to [Main](../README.md)

**Time limit:** 35 minutes

## Overview

This exercise tests your ability to:

- Read an unfamiliar Go HTTP reverse-proxy codebase and reason about it
- Diagnose runtime defects from **symptoms only** (routing, concurrency, resource handling)
- Apply correct, idiomatic fixes
- Extend the proxy with a request-header transform and proper context propagation
- Validate behavior under load

You are given a small but realistic reverse proxy. It **builds and runs as-is**, but it does **not** behave correctly. Three defects are planted (no hints about cause or count); two further items are explicitly marked for you to implement.

## The system

```
client ──▶ proxy (:8080) ──▶ upstream app (:9090, vhost "app.bonkey.internal")
                  │
                  └─▶ token introspection (:9091)
```

- The **proxy** authenticates each request by resolving the `X-Session-Token`
  header to an identity (cached in memory; on a miss it calls the introspection
  service), then forwards the request to the upstream app.
- The **upstream app** is **vhost-strict**: `GET /hello` returns `200` only when
  the forwarded request's `Host` header is `app.bonkey.internal`. It echoes back
  the `X-Bonkey-Identity` header it received.
- The **introspection service** resolves a token to `{active, user, roles}`.

## Available files

| File | Edit? | Purpose |
|------|-------|---------|
| `main.go` | **Yes** | The reverse proxy. Your work goes here. |
| `backend/main.go` | No | Upstream app (`:9090`) + introspection (`:9091`). Do not edit. |
| `loadgen/main.go` | No | Concurrent load generator. Do not edit. |
| `start.sh` | No | Builds & runs backend + proxy (proxy built with the race detector). |
| `load.sh` | No | Drives traffic: `seq` (sequential) or `par` (concurrent). |

## Environment Setup

Run in the BonkeyWonkers Codespace (Go is preinstalled). From this directory:

```bash
cd exercise12
go build ./...          # everything should compile
```

To run the system (backend in the background, proxy in the foreground):

```bash
./start.sh              # Ctrl-C to stop; backend is cleaned up automatically
```

In a **second terminal**, send traffic:

```bash
# a single request (default token)
curl -s -H "X-Session-Token: tok-A" http://127.0.0.1:8080/hello

# sequential load, unique token per request
./load.sh seq 10

# concurrent load, unique token per request
./load.sh par 32 2000
```

> The proxy is built with Go's **race detector** enabled and is configured to
> halt on the first data race, so concurrency problems surface deterministically
> while you work. A clean run prints no `DATA RACE` and the proxy stays up.

## Your tasks

### Step 1 - Get a request working end to end

Start the system and send a single request. It does not succeed. Diagnose why
from what you observe, fix it in `main.go`, and confirm you can get a successful
response from `/hello`.

### Step 2 - Make it stable under load

Exercise the proxy with **sequential** load and then with **concurrent** load.
Each profile reveals a different defect. Diagnose each from its symptom, fix it,
and re-run until both profiles are clean (no stalls, no crash, no data race).

### Step 3 - Inject the caller identity (`// TODO Write 1`)

The upstream app expects the resolved caller identity in the `X-Bonkey-Identity`
request header, JSON-encoded. Implement this on the request forwarded upstream.
A client must **not** be able to supply or spoof this header themselves.

Verify: the upstream echoes the identity back in the JSON response.

### Step 4 - Propagate request context (`// TODO Write 2`)

The outbound introspection call currently ignores the inbound request's context.
Thread a request-scoped context (with a sensible timeout) through to it so that
caller cancellation and deadlines are honored.

## Validation

Your solution is complete when:

```bash
# single request succeeds and carries the identity
curl -s -H "X-Session-Token: tok-A" http://127.0.0.1:8080/hello
# → {"data":"Hello World","identity":"{\"user\":\"bonkey-tok-A\",\"roles\":[\"reader\"]}"}

./load.sh seq 20        # all 200, all fast (no multi-second stalls)
./load.sh par 32 2000   # all 200, no DATA RACE, proxy stays up
```

### Objectives

By completing this exercise, you will demonstrate:

- Reverse-proxy request rewriting (host/vhost handling)
- Concurrency safety for state shared across request goroutines
- Correct HTTP client resource handling and connection-pool behavior
- Safe request-header injection (anti-spoofing)
- Context propagation through outbound calls

## Exercise 12 Complete

Proceed to [Exercise 13](../exercise13/README.md).
