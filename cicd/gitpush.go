package main

import (
	"fmt"
)

func GitPush(args []string)  {
	err := CheckThree(args, "message for commit must be sigle string")
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	
	frames := [][]string{
		[]string{"git","fetch"},
		[]string{"git","add -A"},
		[]string{"git","commit -m" + args[2]},
		[]string{"git","push"},
	}
	
	ExecCmdMulti(frames)
	
	
	
}
