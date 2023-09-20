package main

import (
	"fmt"
)

func GFunc(args []string) {
	err := CheckNum(args, 3, `
	please enter:
		cicd gfunc <command>
			`)
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	cmd := args[len(args)-1]
	 
	switch cmd {
	case "deploy":
		deploy()
	default:
		err := CheckEnd(cmd,`
		please enter:
			cicd gfunc deploy <command>
				`)
		fmt.Println(err.Error())	
	}

}

func deploy() {
	frames := [][]string{
		[]string{"git", "fetch"},
		[]string{"git", "add -A"},
		[]string{"git", "push"},
	}

	ExecCmdMulti(frames)
}
