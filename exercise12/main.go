// Exercise 12 — Bonkey reverse proxy.
//
// This proxy fronts the upstream application on :9090. For every request it
// authenticates the caller (resolving a session token to an identity, via an
// in-memory cache backed by the introspection service on :9091), then forwards
// the request upstream.
//
// It builds and runs as-is, but it does NOT behave correctly. Your job is to
// make it work — see exercise12/README.md.
package main

import (
	"context"
	"encoding/json"
	"net/http"
	"net/http/httputil"
	"net/url"
	"time"

	"log"
)

const (
	listenAddr   = "127.0.0.1:8080"
	upstreamAddr = "http://127.0.0.1:9090"
	introspect   = "http://127.0.0.1:9091/introspect"
)

// Identity is the resolved caller identity injected downstream.
type Identity struct {
	User  string   `json:"user"`
	Roles []string `json:"roles"`
}

// sessionCache maps a session token to its resolved identity so we don't
// introspect the same token twice.
var sessionCache = map[string]Identity{}

// introspectClient calls the token-introspection service. The connection pool
// is deliberately small — connections must be returned to it promptly.
var introspectClient = &http.Client{
	Timeout: 5 * time.Second,
	Transport: &http.Transport{
		MaxConnsPerHost: 2,
	},
}

func main() {
	target, err := url.Parse(upstreamAddr)
	if err != nil {
		log.Fatal(err)
	}
	proxy := httputil.NewSingleHostReverseProxy(target)

	handler := func(w http.ResponseWriter, r *http.Request) {
		id, err := authenticate(r)
		if err != nil {
			http.Error(w, "unauthorized: "+err.Error(), http.StatusUnauthorized)
			return
		}

		// TODO (Write 1): inject the resolved identity into the request that is
		// forwarded UPSTREAM, as the X-Bonkey-Identity header (JSON-encoded).
		// A client must not be able to spoof this header.
		_ = id

		proxy.ServeHTTP(w, r)
	}

	log.Printf("proxy listening on %s -> upstream %s", listenAddr, upstreamAddr)
	log.Fatal(http.ListenAndServe(listenAddr, http.HandlerFunc(handler)))
}

// authenticate resolves the caller's identity from the X-Session-Token header,
// serving from the cache when possible and falling back to introspection.
func authenticate(r *http.Request) (Identity, error) {
	token := r.Header.Get("X-Session-Token")
	if token == "" {
		return Identity{}, errString("missing X-Session-Token")
	}

	if id, ok := sessionCache[token]; ok {
		return id, nil
	}

	id, err := introspectToken(token)
	if err != nil {
		return Identity{}, err
	}
	sessionCache[token] = id
	return id, nil
}

// introspectToken asks the introspection service to resolve a token.
func introspectToken(token string) (Identity, error) {
	// TODO (Write 2): derive a request-scoped context (with a timeout) from the
	// inbound request rather than using context.Background(), so that caller
	// cancellation and deadlines propagate to this outbound call.
	req, err := http.NewRequestWithContext(
		context.Background(),
		http.MethodGet,
		introspect+"?token="+url.QueryEscape(token),
		nil,
	)
	if err != nil {
		return Identity{}, err
	}

	resp, err := introspectClient.Do(req)
	if err != nil {
		return Identity{}, err
	}

	var out struct {
		Active bool     `json:"active"`
		User   string   `json:"user"`
		Roles  []string `json:"roles"`
	}
	if err := json.NewDecoder(resp.Body).Decode(&out); err != nil {
		return Identity{}, err
	}
	if !out.Active {
		return Identity{}, errString("token not active")
	}
	return Identity{User: out.User, Roles: out.Roles}, nil
}

type errString string

func (e errString) Error() string { return string(e) }
