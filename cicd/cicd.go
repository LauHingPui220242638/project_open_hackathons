package main

import (
	"fmt"
	"os"
)

func main() {
	Greeting()
	args := os.Args
	err := CheckNum(args, 2,
		`
		please enter:
			cicd git <command>
			cicd gfunc <command>
		`)
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
	default:
		err := CheckEnd(cmd, `
		please enter:
			cicd git <command>
			cicd gfunc <command>
				`)
		fmt.Println(err.Error())
	}

}
