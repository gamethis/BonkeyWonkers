// IdP + JWKS for Exercise 14 — DO NOT EDIT.
//
// Listens on 127.0.0.1:9091.
//
//	GET /.well-known/jwks.json   the signing key set (one RS256 key)
//	GET /token[?kind=...]        mints a JWT for testing:
//	    valid (default)  good token: sub=alice, aud=bonkey, iss=bonkey-idp
//	    expired          exp in the past
//	    badaud           wrong audience
//	    forged           well-formed, but signed with a key NOT in the JWKS
package main

import (
	"crypto"
	"crypto/rand"
	"crypto/rsa"
	"crypto/sha256"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"log"
	"math/big"
	"net/http"
	"time"
)

const (
	kid    = "bonkey-key-1"
	issuer = "bonkey-idp"
	aud    = "bonkey"
)

var (
	signingKey *rsa.PrivateKey // published in the JWKS
	forgedKey  *rsa.PrivateKey // NOT published — used to forge tokens
)

func b64(b []byte) string { return base64.RawURLEncoding.EncodeToString(b) }

func mint(key *rsa.PrivateKey, sub, audience string, exp time.Time) string {
	header := map[string]any{"alg": "RS256", "typ": "JWT", "kid": kid}
	claims := map[string]any{
		"iss":   issuer,
		"sub":   sub,
		"aud":   audience,
		"exp":   exp.Unix(),
		"iat":   time.Now().Unix(),
		"roles": []string{"reader"},
	}
	hb, _ := json.Marshal(header)
	cb, _ := json.Marshal(claims)
	signingInput := b64(hb) + "." + b64(cb)
	sum := sha256.Sum256([]byte(signingInput))
	sig, _ := rsa.SignPKCS1v15(rand.Reader, key, crypto.SHA256, sum[:])
	return signingInput + "." + b64(sig)
}

func main() {
	var err error
	if signingKey, err = rsa.GenerateKey(rand.Reader, 2048); err != nil {
		log.Fatal(err)
	}
	if forgedKey, err = rsa.GenerateKey(rand.Reader, 2048); err != nil {
		log.Fatal(err)
	}

	mux := http.NewServeMux()
	mux.HandleFunc("/.well-known/jwks.json", func(w http.ResponseWriter, r *http.Request) {
		pub := &signingKey.PublicKey
		jwk := map[string]any{
			"kty": "RSA",
			"use": "sig",
			"alg": "RS256",
			"kid": kid,
			"n":   b64(pub.N.Bytes()),
			"e":   b64(big.NewInt(int64(pub.E)).Bytes()),
		}
		w.Header().Set("Content-Type", "application/json")
		_ = json.NewEncoder(w).Encode(map[string]any{"keys": []any{jwk}})
	})
	mux.HandleFunc("/token", func(w http.ResponseWriter, r *http.Request) {
		now := time.Now()
		var tok string
		switch r.URL.Query().Get("kind") {
		case "expired":
			tok = mint(signingKey, "alice", aud, now.Add(-time.Hour))
		case "badaud":
			tok = mint(signingKey, "alice", "some-other-app", now.Add(time.Hour))
		case "forged":
			tok = mint(forgedKey, "attacker", aud, now.Add(time.Hour))
		default:
			tok = mint(signingKey, "alice", aud, now.Add(time.Hour))
		}
		w.Header().Set("Content-Type", "text/plain")
		fmt.Fprint(w, tok)
	})

	log.Println("idp/jwks listening on 127.0.0.1:9091")
	log.Fatal(http.ListenAndServe("127.0.0.1:9091", mux))
}
