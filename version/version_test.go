package version

import "testing"

func TestGet(t *testing.T) {
	for _, tt := range []string{
		"0",
		"a",
		"0123",
		"asdf",
		"!@#$%^&",
	} {
		gitCommit = tt
		if c := Get().GitCommit; c != tt {
			t.Errorf("handler returned wrong string, got %v want %v", c, tt)
		}
	}
}
