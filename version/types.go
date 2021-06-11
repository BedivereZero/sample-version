package version

type Version struct {
	GitCommit    string `json:"gitCommit"`
	GitVersion   string `json:"gitVersion"`
	GitMajor     string `json:"gitMajor"`
	GitMinor     string `json:"gitMinor"`
	GitTreeState string `json:"gitTreeState"`
	BuildDate    string `json:"buildDate"`
	GoVersion    string `json:"goVersion"`
	Compiler     string `json:"compiler"`
	Platform     string `json:"platform"`
}

func (v *Version) String() string {
	return v.GitVersion
}
