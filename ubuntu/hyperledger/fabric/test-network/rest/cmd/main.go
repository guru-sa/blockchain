package main

import (
	"fmt"
	"os"

	"gopkg.in/alecthomas/kingpin.v2"

	"rest/listener"
	"rest/metadata"
)

var (
	app = kingpin.New("agent", "Mole agent")

	_       = app.Command("start", "Start the agent").Default()
	version = app.Command("version", "Show version information")
)

func main() {
	fullCmd := kingpin.MustParse(app.Parse(os.Args[1:]))

	// "version" command
	if fullCmd == version.FullCommand() {
		fmt.Println(metadata.GetVersionInfo())
		return
	}

	listener.Start()

}
