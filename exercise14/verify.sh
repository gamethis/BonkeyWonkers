#!/usr/bin/env bash
# Exercise 14 — drive test cases through Envoy (:8080) and report PASS/FAIL.
# DO NOT EDIT. Run it (in another terminal) after ./start.sh is up.
set -uo pipefail

idp="http://127.0.0.1:9091/token"
gw="http://127.0.0.1:8080/hello"

tok() { curl -s "$idp?kind=$1"; }

run() {
  local name="$1" expect="$2"
  shift 2
  local code
  code=$(curl -s -o /dev/null -w '%{http_code}' "$@" "$gw")
  if [ "$code" = "$expect" ]; then
    echo "PASS  $name -> $code"
  else
    echo "FAIL  $name -> $code (want $expect)"
  fi
}

echo "expected end state: a valid token succeeds; everything else is denied."
run "valid token"      200 -H "Authorization: Bearer $(tok valid)"
run "forged signature" 403 -H "Authorization: Bearer $(tok forged)"
run "expired token"    403 -H "Authorization: Bearer $(tok expired)"
run "wrong audience"   403 -H "Authorization: Bearer $(tok badaud)"
run "no token"         403
