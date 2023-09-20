package main

import (
	"fmt"
)

func GitM2B(args []string)  {
	err := CheckNum(args, 3, "branch for merge must be sigle string")
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	
	branch := args[2]
	frames := [][]string{
		[]string{"git","add -A"},
		[]string{"git","commit -m m2b_" + branch},
		[]string{"git","checkout main"},
		[]string{"git","checkout " + branch},
		[]string{"git","merge main"},
		[]string{"git","commit -m"},
		[]string{"git","push"},
	}
	
	ExecCmdMulti(frames)
	
	
	
}
