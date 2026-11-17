package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"time"
)

var buildLabel = "baseline"

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("GET /", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/plain")
		fmt.Fprintf(w, "%s %s\n", os.Getenv("SLOT"), buildLabel)
	})
	server := &http.Server{Addr: ":8080", Handler: mux, ReadHeaderTimeout: 3 * time.Second}
	log.Fatal(server.ListenAndServe())
}
