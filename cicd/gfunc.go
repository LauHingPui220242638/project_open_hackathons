package main

import (
	"fmt"
)

func GFunc(args []string) {
	err := CheckThree(args, `
	please enter:
		cicd gfunc <command>
			`)
	if err != nil {
		fmt.Println(err.Error())
		return
	}

	// switch cmd {
	// case "deploy":
	// 	deploy()
	// default:
	// 	return
	// }

}

func deploy() {
	frames := [][]string{
		[]string{"git", "fetch"},
		[]string{"git", "add -A"},
		[]string{"git", "push"},
	}

	ExecCmdMulti(frames)
}
