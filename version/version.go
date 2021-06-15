package version

import (
	"runtime"
)

func Get() *Version {
	return &Version{
		GitCommit:    gitCommit,
		GitVersion:   gitVersion,
		GitMajor:     gitMajor,
		GitMinor:     gitMinor,
		GitTreeState: gitTreeState,
		BuildDate:    buildDate,
		GoVersion:    runtime.Version(),
		Compiler:     runtime.Compiler,
		Platform:     runtime.GOOS + "/" + runtime.GOARCH,
	}
}
