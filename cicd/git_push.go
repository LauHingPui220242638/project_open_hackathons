package main

import (
	"fmt"
)

func GitPush(args []string) {
	err := CheckNum(args, 4, "message for commit must be sigle string")
	if err != nil {
		fmt.Println(err.Error())
		return
	}

	message := args[3]
	frames := [][]string{
		[]string{"git", "fetch"},
		[]string{"git", "add -A"},
		[]string{"git", "commit -m" + message},
		[]string{"git", "push"},
	}

	ExecCmdMulti(frames)

}
