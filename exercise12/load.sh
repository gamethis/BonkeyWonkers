#!/usr/bin/env bash
# Exercise 12 — drive traffic at the proxy (http://127.0.0.1:8080/hello).
#
#   ./load.sh seq [count]      sequential requests, each with a UNIQUE token
#                              (curl; prints "<http_code> <total_time>" per line)
#   ./load.sh par [conc] [n]   concurrent load from real worker goroutines,
#                              each request a UNIQUE token (prints a code tally)
#
# Tokens are unique per request, so every request is a cache miss.
set -uo pipefail
cd "$(dirname "$0")"

mode="${1:-seq}"
url="http://127.0.0.1:8080/hello"

case "$mode" in
  seq)
    count="${2:-20}"
    echo "sequential: $count requests, unique tokens"
    for i in $(seq 1 "$count"); do
      curl -s -o /dev/null -w "%{http_code} %{time_total}s\n" \
        -H "X-Session-Token: seq-$i" "$url"
    done
    ;;
  par)
    conc="${2:-32}"
    n="${3:-2000}"
    go run ./loadgen -c "$conc" -n "$n" -url "$url"
    ;;
  *)
    echo "usage: $0 [seq|par] ..." >&2
    exit 2
    ;;
esac
