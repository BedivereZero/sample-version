package main

import (
	"encoding/json"
	"log"
	"os"

	"github.com/BedivereZero/sample-version/version"
)

func main() {
	v := version.Get()
	data := struct {
		Variables *version.Version  `json:"variables"`
		Functions map[string]string `json:"functions"`
	}{
		Variables: v,
		Functions: map[string]string{
			"string": v.String(),
		},
	}

	if err := json.NewEncoder(os.Stdout).Encode(&data); err != nil {
		log.Fatal(err)
	}
}
