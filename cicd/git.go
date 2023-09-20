package main

import (
	"fmt"
)

func Git(args []string)  {
	err := CheckNum(args, 3, `
	please enter:
		cicd git <command>
			`)
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	
	cmd := args[2]
	 
	switch cmd {
	case "push":
		deploy()
	case "m2b":
		deploy()
	case "b2m":
		deploy()
	default:
		err := CheckEnd(cmd,`
		please enter:
			cicd git push <message>
			cicd git m2b <message>
			cicd git b2m <message>
				`)
		fmt.Println(err.Error())	
	}
	
	frames := [][]string{
		[]string{"git","fetch"},
		[]string{"git","add -A"},
		[]string{"git","commit -m" + args[2]},
		[]string{"git","push"},
	}
	
	ExecCmdMulti(frames)
	
	
	
}
