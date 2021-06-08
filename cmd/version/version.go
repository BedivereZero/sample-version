package main

import (
	"fmt"
	"runtime"
)

var (
	version      = "v0.0.0"
	gitCommit    = ""
	gitTreeState = ""
)

type BuildInfo interface {
	String() string
}

type buildInfo struct {
	Version      string `json:"version"`
	GitCommit    string `json:"gitCommit"`
	GitTreeState string `json:"gitTreeState"`
	GoVersion    string `json:"goVersion"`
}

func (i *buildInfo) String() string {
	format := "Version: %q\nGitCommit: %q\nGitTreeState: %q\nGoVersion: %q\n"
	return fmt.Sprintf(format, i.Version, i.GitCommit, i.GitTreeState, i.GoVersion)
}

func Get() BuildInfo {
	v := buildInfo{
		Version:      version,
		GitCommit:    gitCommit,
		GitTreeState: gitTreeState,
		GoVersion:    runtime.Version(),
	}
	return &v
}

func main() {
	fmt.Print(Get().String())
}
