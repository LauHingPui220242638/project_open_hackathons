package main

import (
	"fmt"
	"os"
)

func main() {
	Greeting()
	args := os.Args
	prompt := `
	please enter:
		cicd git <command>
		cicd gfunc <command>
		cicd build
	`
	err := CheckNum(args, 2, prompt)
	if err != nil {
		fmt.Println(err.Error())
		return
	}

	cmd := args[1]

	switch cmd {
	case "git":
		Git(args)
	case "gfunc":
		GFunc(args)
	case "build":
		Build(args)
	default:
		err := CheckEnd(cmd, prompt)
		fmt.Println(err.Error())
	}

}
