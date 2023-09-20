package main

import (
	"errors"
	"fmt"
	"os"
)

func main() {
	Greeting()
	args := os.Args
	if len(args) < 2 {
		err := errors.New(
			`
please enter:
	cicd gitpush <message>
	cicd gfunc <command>
`)
		fmt.Println(err.Error())
		return
	}

	cmd := args[1]

	switch cmd {
	case "git":
		Git(args)
	case "gfunc":
		GFunc(args)
	default:
		err := CheckEnd(cmd, `
		please enter:
			cicd gitpush <message>
			cicd gfunc <command>
				`)
		fmt.Println(err.Error())
	}

}
