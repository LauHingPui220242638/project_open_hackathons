package main

import (
	"fmt"
)

func Git(args []string)  {
	prompt := `
	please enter:
			cicd git push <message>
			cicd git m2b <branch>
			cicd git b2m <branch>
			`
	err := CheckNum(args, 3, prompt)
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
		GitB2M(args)
	default:
		err := CheckEnd(cmd, prompt)
		fmt.Println(err.Error())	
	}
	
	
	
	
	
}