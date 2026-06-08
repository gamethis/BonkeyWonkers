// Bonkey Modern-Auth proxy for Exercise 14 — THIS is the file you edit.
//
// It runs as Envoy's external authorization (ext_authz) HTTP service on
// 127.0.0.1:9000. For each request Envoy forwards here, the proxy:
//  1. validates the caller's JWT (Authorization: Bearer ...) against the IdP
//     JWKS, and
//  2. on success, returns a SIGNED X-Bonkey-Identity header that Envoy injects
//     upstream (the upstream trusts only a correctly-signed header).
//
// A 200 response authorizes the request; any other status denies it.
//
// It builds and runs as-is, but it does NOT behave correctly. See README.md.
package main

import (
	"crypto/hmac"
	"crypto/rsa"
	"crypto/sha256"
	"encoding/base64"
	"encoding/json"
	"errors"
	"log"
	"math/big"
	"net/http"
	"strings"
	"time"
)

const (
	jwksURL    = "http://127.0.0.1:9091/.well-known/jwks.json"
	wantIssuer = "bonkey-idp"
	wantAud    = "bonkey"
	hmacSecret = "bonkey-shared-secret" // shared with the upstream
)

func b64dec(s string) ([]byte, error) { return base64.RawURLEncoding.DecodeString(s) }
func b64enc(b []byte) string          { return base64.RawURLEncoding.EncodeToString(b) }
func mustJSON(v any) []byte           { b, _ := json.Marshal(v); return b }

// --- JWKS (provided, working) ------------------------------------------------

type jwk struct {
	Kid string `json:"kid"`
	N   string `json:"n"`
	E   string `json:"e"`
}

// fetchKey pulls the signing key from the IdP JWKS and rebuilds the RSA public
// key. (Provided — you do not need to change this.)
func fetchKey(kid string) (*rsa.PublicKey, error) {
	resp, err := http.Get(jwksURL)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()
	var set struct {
		Keys []jwk `json:"keys"`
	}
	if err := json.NewDecoder(resp.Body).Decode(&set); err != nil {
		return nil, err
	}
	for _, k := range set.Keys {
		if k.Kid != kid {
			continue
		}
		nb, err := b64dec(k.N)
		if err != nil {
			return nil, err
		}
		eb, err := b64dec(k.E)
		if err != nil {
			return nil, err
		}
		e := 0
		for _, x := range eb {
			e = e<<8 | int(x)
		}
		return &rsa.PublicKey{N: new(big.Int).SetBytes(nb), E: e}, nil
	}
	return nil, errors.New("kid not found in JWKS")
}

// --- token validation --------------------------------------------------------

type claims struct {
	Iss   string   `json:"iss"`
	Sub   string   `json:"sub"`
	Aud   string   `json:"aud"`
	Exp   int64    `json:"exp"`
	Roles []string `json:"roles"`
}

// validate parses and validates a bearer JWT and returns its claims.
func validate(token string) (*claims, error) {
	parts := strings.Split(token, ".")
	if len(parts) != 3 {
		return nil, errors.New("malformed token")
	}
	signingInput := parts[0] + "." + parts[1]

	var hdr struct {
		Alg string `json:"alg"`
		Kid string `json:"kid"`
	}
	hb, err := b64dec(parts[0])
	if err != nil {
		return nil, err
	}
	if err := json.Unmarshal(hb, &hdr); err != nil {
		return nil, err
	}

	cb, err := b64dec(parts[1])
	if err != nil {
		return nil, err
	}
	var c claims
	if err := json.Unmarshal(cb, &c); err != nil {
		return nil, err
	}

	// TODO (#1): verify the token signature BEFORE trusting any claim. Right
	// now any well-formed token is accepted — a forged token signed by an
	// unknown key passes. Fetch the key with fetchKey(hdr.Kid) and verify the
	// RS256 signature (RSA PKCS#1 v1.5 + SHA-256) over signingInput against
	// parts[2]. Reject the token if the signature does not verify.
	_ = signingInput

	// Claim checks (provided).
	if c.Iss != wantIssuer {
		return nil, errors.New("bad issuer")
	}
	if c.Aud != wantAud {
		return nil, errors.New("bad audience")
	}
	if time.Now().Unix() >= c.Exp {
		return nil, errors.New("token expired")
	}
	return &c, nil
}

// --- signed identity header --------------------------------------------------

// signIdentity returns the value for the X-Bonkey-Identity header: the identity
// JSON plus an HMAC the upstream verifies. (Provided helper — call it.)
func signIdentity(c *claims) string {
	payload := b64enc(mustJSON(map[string]any{"user": c.Sub, "roles": c.Roles}))
	mac := hmac.New(sha256.New, []byte(hmacSecret))
	mac.Write([]byte(payload))
	return payload + "." + b64enc(mac.Sum(nil))
}

// --- ext_authz HTTP server ---------------------------------------------------

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		auth := r.Header.Get("Authorization")
		token := strings.TrimPrefix(auth, "Bearer ")
		if token == "" || token == auth {
			http.Error(w, "missing bearer token", http.StatusForbidden)
			return
		}
		c, err := validate(token)
		if err != nil {
			http.Error(w, "unauthorized: "+err.Error(), http.StatusForbidden)
			return
		}

		// TODO (#2): the upstream trusts X-Bonkey-Identity only when it is
		// signed. Send the SIGNED value (signIdentity) instead of the raw,
		// spoofable JSON below.
		w.Header().Set("X-Bonkey-Identity", string(mustJSON(map[string]any{"user": c.Sub, "roles": c.Roles})))

		w.WriteHeader(http.StatusOK)
	})

	log.Println("ext_authz proxy listening on 127.0.0.1:9000")
	log.Fatal(http.ListenAndServe("127.0.0.1:9000", nil))
}
