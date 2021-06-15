package version

import "testing"

func TestString(t *testing.T) {
	for _, tt := range []string{
		"0",
		"a",
		"0123",
		"asdf",
		"!@#$%^&",
	} {
		v := Version{GitVersion: tt}
		if v.String() != tt {
			t.Errorf("handler returned wrong string, got %v want %v", v.String(), tt)
		}
	}
}

func BenchmarkString(t *testing.B) {
	v := Get()
	var s string
	t.ResetTimer()
	for i := 0; i < t.N; i++ {
		s = v.String()
	}
	// Avoid warning: unused result
	_ = s
}
