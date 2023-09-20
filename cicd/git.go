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
		GitPush(args)
	case "m2b":
		GitM2B(args)
	case "b2m":
		deploy()
	default:
		err := CheckEnd(cmd,`
		please enter:
			cicd git push <message>
			cicd git m2b <branch>
			cicd git b2m <branch>
				`)
		fmt.Println(err.Error())	
	}
	
	
	
	
	
}