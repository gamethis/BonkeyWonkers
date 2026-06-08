// Concurrent load generator for Exercise 12 — DO NOT EDIT.
//
// Fires many requests at the proxy at once, each with a UNIQUE session token,
// from a pool of real concurrent workers. Prints a status-code tally and the
// slowest request. Use it to exercise the proxy under genuine concurrency.
//
//	go run ./loadgen                 # defaults: 32 workers, 2000 requests
//	go run ./loadgen -c 64 -n 5000   # tune concurrency / total
package main

import (
	"flag"
	"fmt"
	"net/http"
	"sync"
	"sync/atomic"
	"time"
)

func main() {
	concurrency := flag.Int("c", 32, "concurrent workers")
	total := flag.Int("n", 2000, "total requests")
	target := flag.String("url", "http://127.0.0.1:8080/hello", "proxy URL")
	flag.Parse()

	client := &http.Client{Timeout: 10 * time.Second}
	var (
		next   int64
		codes  sync.Map // int -> *int64
		maxDur int64    // nanoseconds
		errs   int64
		wg     sync.WaitGroup
	)
	bump := func(code int) {
		v, _ := codes.LoadOrStore(code, new(int64))
		atomic.AddInt64(v.(*int64), 1)
	}

	start := time.Now()
	for w := 0; w < *concurrency; w++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			for {
				i := atomic.AddInt64(&next, 1)
				if i > int64(*total) {
					return
				}
				req, _ := http.NewRequest(http.MethodGet, *target, nil)
				req.Header.Set("X-Session-Token", fmt.Sprintf("load-%d", i))
				t0 := time.Now()
				resp, err := client.Do(req)
				d := time.Since(t0).Nanoseconds()
				for {
					m := atomic.LoadInt64(&maxDur)
					if d <= m || atomic.CompareAndSwapInt64(&maxDur, m, d) {
						break
					}
				}
				if err != nil {
					atomic.AddInt64(&errs, 1)
					continue
				}
				bump(resp.StatusCode)
				resp.Body.Close()
			}
		}()
	}
	wg.Wait()

	fmt.Printf("sent %d requests, %d workers, in %s\n", *total, *concurrency, time.Since(start).Round(time.Millisecond))
	codes.Range(func(k, v any) bool {
		fmt.Printf("  HTTP %d: %d\n", k.(int), atomic.LoadInt64(v.(*int64)))
		return true
	})
	fmt.Printf("  errors (timeout/conn): %d\n", atomic.LoadInt64(&errs))
	fmt.Printf("  slowest request: %s\n", time.Duration(atomic.LoadInt64(&maxDur)).Round(time.Millisecond))
}
