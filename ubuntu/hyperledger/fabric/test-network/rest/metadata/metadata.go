package metadata

import (
	"fmt"
	"runtime"
)

const ProgramName = "agent"

var Version = "demo"
var CommitSHA = "development build"

func GetVersionInfo() string {
	return fmt.Sprintf(
		"%s:\n Version: %s\n Commit SHA: %s\n Go version: %s\n OS/Arch: %s\n",
		ProgramName,
		Version,
		CommitSHA,
		runtime.Version(),
		fmt.Sprintf("%s/%s", runtime.GOOS, runtime.GOARCH),
	)
}