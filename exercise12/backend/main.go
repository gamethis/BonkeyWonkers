// Backend services for Exercise 12 — DO NOT EDIT.
//
// Runs two listeners:
//
//	:9090  the upstream application. It is vhost-strict: GET /hello only
//	       returns 200 when the request's Host header is "app.bonkey.internal".
//	       It echoes back whatever X-Bonkey-Identity header it received.
//	:9091  a token-introspection service. GET /introspect?token=... returns
//	       whether the token is active plus a resolved user + roles.
package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strings"
	"sync/atomic"
)

const wantHost = "app.bonkey.internal"

var introspectCalls int64

func main() {
	app := http.NewServeMux()
	app.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		_, _ = w.Write([]byte(`{"status":"ok"}`))
	})
	app.HandleFunc("/hello", func(w http.ResponseWriter, r *http.Request) {
		if r.Host != wantHost {
			http.Error(w, fmt.Sprintf("404 no vhost configured for Host=%q", r.Host), http.StatusNotFound)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		_ = json.NewEncoder(w).Encode(map[string]any{
			"data":     "Hello World",
			"identity": r.Header.Get("X-Bonkey-Identity"),
		})
	})
	go func() {
		log.Printf("upstream app  listening on 127.0.0.1:9090 (serves vhost %q)", wantHost)
		log.Fatal(http.ListenAndServe("127.0.0.1:9090", app))
	}()

	intro := http.NewServeMux()
	intro.HandleFunc("/introspect", func(w http.ResponseWriter, r *http.Request) {
		n := atomic.AddInt64(&introspectCalls, 1)
		token := r.URL.Query().Get("token")
		log.Printf("introspect #%d token=%q", n, token)
		w.Header().Set("Content-Type", "application/json")
		_ = json.NewEncoder(w).Encode(map[string]any{
			"active": token != "",
			"user":   "bonkey-" + token,
			"roles":  []string{"reader"},
		})
		// The response is chunked (no Content-Length) and carries a verbose
		// trailing audit line after the JSON value. A client that decodes only
		// the JSON value, and does not close the body, leaves the connection
		// part-read so it can never be returned to the pool.
		_, _ = w.Write([]byte("\n# audit: token=" + token + " " + strings.Repeat(" ", 2048) + "\n"))
	})
	log.Println("introspection listening on 127.0.0.1:9091")
	log.Fatal(http.ListenAndServe("127.0.0.1:9091", intro))
}
