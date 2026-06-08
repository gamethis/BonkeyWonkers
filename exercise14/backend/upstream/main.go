// Upstream application for Exercise 14 — DO NOT EDIT.
//
// Listens on 127.0.0.1:9090. GET /hello returns the caller identity, but only
// if the X-Bonkey-Identity header carries a valid HMAC signature (a secret it
// shares with the proxy). An unsigned, altered, or client-spoofed header is
// rejected with 401 — a caller cannot assert its own identity.
//
// Header format:  <base64url(identity-json)>.<base64url(HMAC-SHA256 of part 1)>
package main

import (
	"crypto/hmac"
	"crypto/sha256"
	"crypto/subtle"
	"encoding/base64"
	"encoding/json"
	"log"
	"net/http"
	"strings"
)

// Shared secret with the proxy (would be sourced from a secret store in prod).
const hmacSecret = "bonkey-shared-secret"

func hmacOf(b []byte) []byte {
	m := hmac.New(sha256.New, []byte(hmacSecret))
	m.Write(b)
	return m.Sum(nil)
}

func verifyIdentity(header string) (map[string]any, bool) {
	payload, sig, ok := strings.Cut(header, ".")
	if !ok {
		return nil, false
	}
	want := hmacOf([]byte(payload))
	got, err := base64.RawURLEncoding.DecodeString(sig)
	if err != nil || subtle.ConstantTimeCompare(want, got) != 1 {
		return nil, false
	}
	raw, err := base64.RawURLEncoding.DecodeString(payload)
	if err != nil {
		return nil, false
	}
	var id map[string]any
	if err := json.Unmarshal(raw, &id); err != nil {
		return nil, false
	}
	return id, true
}

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		_, _ = w.Write([]byte(`{"status":"ok"}`))
	})
	mux.HandleFunc("/hello", func(w http.ResponseWriter, r *http.Request) {
		id, ok := verifyIdentity(r.Header.Get("X-Bonkey-Identity"))
		if !ok {
			http.Error(w, `{"error":"missing or invalid identity"}`, http.StatusUnauthorized)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		_ = json.NewEncoder(w).Encode(map[string]any{"data": "Hello World", "identity": id})
	})

	log.Println("upstream listening on 127.0.0.1:9090")
	log.Fatal(http.ListenAndServe("127.0.0.1:9090", mux))
}
